import 'package:flutter/material.dart';

showSnackBar(context,msg) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content:  Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: const  Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        elevation: 3.0,
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      
      ),
    );
}
