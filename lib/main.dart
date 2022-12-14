import 'dart:convert';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/app/app.locator.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:testapp/services/http_service.dart';

import 'data/enums.dart';
import 'data/urls.dart';

final HttpService _httpService = locator<HttpService>();
var musicURL = "";

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController audioSearch = TextEditingController();
  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  String audioasset = "assets/audio/Covenant-keeping-God.mp3";
  bool isplaying = false;
  bool audioplayed = false;
  late Uint8List audiobytes;

  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ByteData bytes =
          await rootBundle.load(audioasset); //load audio from assets
      audiobytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      //convert ByteData to Uint8List

      player.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxduration = d.inMilliseconds;
        setState(() {});
      });

      player.onAudioPositionChanged.listen((Duration p) {
        currentpos =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentpos).inHours;
        int sminutes = Duration(milliseconds: currentpos).inMinutes;
        int sseconds = Duration(milliseconds: currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Play Audio in Music_Plus"),
            backgroundColor: Colors.redAccent),
        body: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Text(
                currentpostlabel,
                style: TextStyle(fontSize: 25),
              ),
              Slider(
                value: double.parse(currentpos.toString()),
                min: 0,
                max: double.parse(maxduration.toString()),
                divisions: maxduration,
                label: currentpostlabel,
                onChanged: (double value) async {
                  int seekval = value.round();
                  int result =
                      await player.seek(Duration(milliseconds: seekval));
                  if (result == 1) {
                    //seek successful
                    currentpos = seekval;
                  } else {
                    print("Seek unsuccessful.");
                  }
                },
              ),
              Wrap(
                spacing: 10,
                children: [
                  ElevatedButton.icon(
                      onPressed: () async {
                        if (!isplaying && !audioplayed) {
                          int result = await player.playBytes(audiobytes);
                          if (result == 1) {
                            //play success
                            setState(() {
                              isplaying = true;
                              audioplayed = true;
                            });
                          } else {
                            print("Error while playing audio.");
                          }
                        } else if (audioplayed && !isplaying) {
                          int result = await player.resume();
                          if (result == 1) {
                            //resume success
                            setState(() {
                              isplaying = true;
                              audioplayed = true;
                            });
                          } else {
                            print("Error on resume audio.");
                          }
                        } else {
                          int result = await player.pause();
                          if (result == 1) {
                            //pause success
                            setState(() {
                              isplaying = false;
                            });
                          } else {
                            print("Error on pause audio.");
                          }
                        }
                      },
                      icon: Icon(isplaying ? Icons.pause : Icons.play_arrow),
                      label: Text(isplaying ? "Pause" : "Play")),
                  ElevatedButton.icon(
                      onPressed: () async {
                        int result = await player.stop();
                        if (result == 1) {
                          //stop success
                          setState(() {
                            isplaying = false;
                            audioplayed = false;
                            currentpos = 0;
                          });
                        } else {
                          print("Error on stop audio.");
                        }
                      },
                      icon: Icon(Icons.stop),
                      label: const Text("Stop")),
                ],
              ),
              TextField(
                controller: audioSearch,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Audio Name',
                    hintText: 'Enter Audio Name'),
              ),
              ElevatedButton(
                onPressed: () async {
                  String res = await _httpService.sendRequest(
                    HTTPMethod.get,
                    textText,
                  );

                  List resJson = json.decode(res);
                  for (var i = 0; i < resJson.length; i++) {
                    if (resJson[i]["name"]
                        .toLowerCase()
                        .contains(audioSearch.text.toLowerCase())) {
                      // Try to load audio from a source and catch any errors.
                      musicURL = resJson[i]["webViewLink"];
                      print(resJson[i]);
                      // await launchUrl(Uri.parse(musicURL));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Song()),
                      );
                      break;
                    }
                  }
                },
                child: const Text(
                  "Search",
                  style: TextStyle(fontSize: 17, color: Colors.black87),
                ),
              ),
            ],
          ),
        ));
  }
}

class Song extends StatelessWidget {
  const Song({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(musicURL)),
    )));
  }
}
