import 'package:flutter/material.dart';
import 'package:testapp/data/colors.dart';

class HomeMenuTile extends StatelessWidget {
  final String title;
  final Widget route;
  final IconData leadingIcon;

  const HomeMenuTile({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.route,
    // required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // _progressService.showSnackBar("Processing", "Please wait...");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(leadingIcon,size: 32,color: splashColor,),
            const SizedBox(height: 5,),
            Text(title,textAlign: TextAlign.center,style:const TextStyle(fontWeight: FontWeight.w500),),
          ],
        ),
      ),
    );
  }
}
