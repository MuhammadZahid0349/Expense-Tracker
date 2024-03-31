// ignore_for_file: must_be_immutable

import 'package:expense_tracker/Constants/ColorConstants.dart';
import 'package:expense_tracker/Constants/utils.dart';
import 'package:expense_tracker/Controllers/user_record_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Constants/ImagesPath.dart';
import '../data/model/user_model.dart';

class UserRecordScreen extends StatelessWidget {
  UserRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserRecordController userController = Get.put(UserRecordController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: customizedText(text: "Enter Your Details"),
        centerTitle: true,
        backgroundColor: logoColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              5.h.heightBox,
              Center(
                child: Image.asset(
                  AssetsPathImages.logo,
                  height: 150.h,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    15.h.heightBox,
                    customizedText(
                        text: "Enter Your Name:",
                        color: logoColor,
                        fontWeight: FontWeight.w600,
                        size: 16.sp),
                    8.h.heightBox,
                    CupertinoTextField(
                      controller: userController.nameController,
                      keyboardType: TextInputType.name,
                    ),
                    15.h.heightBox,
                    customizedText(
                        text: "Email:",
                        color: logoColor,
                        fontWeight: FontWeight.w600,
                        size: 16.sp),
                    8.h.heightBox,
                    CupertinoTextField(
                      controller: userController.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    15.h.heightBox,
                    customizedText(
                        text: "Age:",
                        color: logoColor,
                        fontWeight: FontWeight.w600,
                        size: 16.sp),
                    8.h.heightBox,
                    CupertinoTextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                      ],
                      keyboardType: TextInputType.phone,
                      controller: userController.ageController,
                    ),
                    15.h.heightBox,
                    customizedText(
                        text: "Date & Time",
                        color: logoColor,
                        fontWeight: FontWeight.w600,
                        size: 15.sp),
                    const Divider(
                      color: kSecColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        customizedText(
                            text: userController.currentDate,
                            size: 11.sp,
                            color: black),
                        customizedText(
                            text: userController.currentTime,
                            size: 11.sp,
                            color: black),
                      ],
                    ),
                    const Divider(
                      color: kSecColor,
                    ),
                  ],
                ),
              ),
              15.h.heightBox,
              customziedButton(
                onFunction: () {
                  userController.saveUserDetails();
                },
                text: "Save",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
