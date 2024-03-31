import 'package:expense_tracker/Screens/dashboard-screens/dashboard_screen.dart';
import 'package:expense_tracker/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/ColorConstants.dart';

class UserRecordController extends GetxController {
  late SharedPreferences _prefs;
  late final Box<UserData> userBox;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String currentDate = DateFormat("dd-MMMM-yyyy").format(DateTime.now());
  String currentTime = DateFormat("hh:mm a").format(DateTime.now());

  @override
  void onInit() {
    // Initialize SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
    super.onInit();
  }

  void saveUserDetails() {
    final name = nameController.text;
    final email = emailController.text;
    final age = ageController.text;

    // Save user details to SharedPreferences
    _prefs.setString('name', name);
    _prefs.setString('email', email);
    _prefs.setString('age', age);
    _prefs.setString('currentDate', currentDate);
    _prefs.setString('currentTime', currentTime);

    // Navigate to dashboard screen
    Get.offAll(() => DashBoardScreen());
  }

  @override
  void onClose() {
    // Dispose controllers
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    super.onClose();
  }
}
