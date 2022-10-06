import 'package:http/http.dart';
import 'package:testapp/data/enums.dart';
import 'package:testapp/data/texts.dart';
import 'package:testapp/data/urls.dart';
import 'package:testapp/utils/custom_logger.dart';

class HttpService {
  Future<String> sendRequest(
    HTTPMethod method,
    String endPoint, {
    String? data = "",
  }) async {
    String message = '';
    String url = hostApi + endPoint;

    logger.i("HTTP STAT: SENDING [$method] REQUEST TO $url");

    try {
      Response res = method == HTTPMethod.post
          ? await post(Uri.parse(url))
          : await get(Uri.parse(url));
      logger.i("HTTP STAT: REQUEST SENT");
      logger.i("HTTP STAT: $endPoint RES => ${res.body}");
      message = res.body;
    } catch (e) {
      logger.e("ERROR STAT: HTTP, $e");
      message = "An error occurred!";
    }
    return message;
  }

  // Future<String> getData({
  //   String? data,
  //   String? endPoint,
  // }) async {
  //   String message = '';
  //   String url =
  //       hostApi + endPoint! + data! + "&verificationText=$verificationText";

  //   logger.i("HTTP STAT: SENDING [GET] REQUEST TO $url");
  //   try {
  //     Response res = await get(Uri.parse(url));
  //     logger.i("HTTP STAT: REQUEST SENT");
  //     logger.i("HTTP STAT: $endPoint RES => ${res.body}");
  //     message = res.body;
  //   } catch (e) {
  //     logger.e("ERROR STAT: HTTP, $e");
  //     message = "An error occurred!";
  //   }

  //   return message;
  // }
}
