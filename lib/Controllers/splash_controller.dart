import 'dart:async';
import 'package:expense_tracker/Controllers/user_record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final Widget destinationPage;

  SplashController({required this.destinationPage});

  @override
  void onInit() {
    super.onInit();
    // Add your timer logic here
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => destinationPage);
    });
  }
}
