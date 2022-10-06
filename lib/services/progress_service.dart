import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/data/colors.dart';

class ProgressService {
  void showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: splashColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10.0),
      colorText: whiteColor,
    );
  }
}
