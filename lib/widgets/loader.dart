import 'package:flutter/material.dart';
import 'package:testapp/data/colors.dart';

class Loader extends StatelessWidget {
  const Loader({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height:MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black12,
        child: const Center(child: CircularProgressIndicator(color: splashColor,)),
      ),
    );
  }
}
