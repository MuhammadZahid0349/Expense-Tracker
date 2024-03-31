// ignore_for_file: unused_local_variable, unused_import, use_key_in_widget_constructors

import 'dart:async';
import 'package:expense_tracker/Constants/ColorConstants.dart';
import 'package:expense_tracker/Constants/ImagesPath.dart';
import 'package:expense_tracker/Constants/utils.dart';
import 'package:expense_tracker/Controllers/splash_controller.dart';
import 'package:expense_tracker/Screens/dashboard-screens/dashboard_screen.dart';
import 'package:expense_tracker/Screens/user_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(), // Get SharedPreferences instance
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        final SharedPreferences prefs = snapshot.data!;

        final String? name = prefs.getString('name');
        final String? email = prefs.getString('email');
        final String? age = prefs.getString('age');

        if (name != null && email != null && age != null) {
          // If user details are already stored, navigate to dashboard screen
          SplashController splashController =
              Get.put(SplashController(destinationPage: DashBoardScreen()));
          return const splash_body();
        } else {
          // If user details are not stored, navigate to user record screen
          SplashController splashController =
              Get.put(SplashController(destinationPage: UserRecordScreen()));
          return const splash_body();
        }
      },
    );
  }
}

class splash_body extends StatelessWidget {
  const splash_body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "SoftNetix Task 2"
                .text
                .uppercase
                .fontFamily("poppins_bold")
                .size(25.sp)
                .letterSpacing(3)
                .color(MColor)
                .make(),
            8.h.heightBox,
            Center(
              child: Image.asset(
                AssetsPathImages.logo,
                height: 180.h,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
        child: customizedText(
            text:
                "Work honestly and sincerely, and you will achieve the goal of building up a prosperous and strong nation. Save money and utilize it for the welfare of your country. Remember, every penny saved contributes to the betterment of our beloved homeland",
            color: Colors.brown,
            textalign: TextAlign.center,
            size: 13.sp,
            btwSpace: 1.3,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
