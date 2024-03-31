import 'package:expense_tracker/Constants/utils.dart';
import 'package:expense_tracker/Screens/home-screen/home-widget/home_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

import '../../../Constants/ColorConstants.dart';
import '../../../Constants/ImagesPath.dart';
import '../../../data/utlity.dart';

class HomeHeadContainer extends StatelessWidget {
  const HomeHeadContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(), // Get SharedPreferences instance
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display loading indicator while fetching data
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final SharedPreferences prefs = snapshot.data!;

        final String name =
            prefs.getString('name') ?? 'Guest'; // Default name if not found

        return Column(
          children: [
            Container(
              height: 200.h,
              width: Get.width,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: MColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Column(
                children: [
                  28.h.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customizedText(
                          text: "Total balance",
                          fontWeight: FontWeight.w700,
                          size: 17.sp),
                      Container(
                          height: 40.h,
                          width: 40.w,
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.h, vertical: 8.w),
                          decoration: const BoxDecoration(
                              color: white, shape: BoxShape.circle),
                          child: Image.asset(AssetsPathImages.logo))
                    ],
                  ),
                  7.h.heightBox,
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        customizedText(
                            text: "Rs: ${total()}",
                            size: 20.sp,
                            fontWeight: FontWeight.bold),
                        customizedText(
                            text: name, // Display the fetched name here
                            size: 18.sp,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                  20.h.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13.r,
                              backgroundColor:
                                  const Color.fromARGB(255, 85, 145, 141),
                              child: Icon(
                                Icons.arrow_downward,
                                color: Colors.white,
                                size: 19.sp,
                              ),
                            ),
                            7.w.widthBox,
                            customizedText(
                                text: "Income",
                                color: const Color.fromARGB(255, 216, 216, 216),
                                size: 15.sp),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13.r,
                              backgroundColor:
                                  const Color.fromARGB(255, 85, 145, 141),
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.white,
                                size: 19.sp,
                              ),
                            ),
                            7.w.widthBox,
                            customizedText(
                                text: "Expenses",
                                color: const Color.fromARGB(255, 216, 216, 216),
                                size: 15.sp),
                          ],
                        ),
                      ],
                    ),
                  ),
                  6.h.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customizedText(
                          text: 'Rs: ${income()}',
                          size: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        customizedText(
                          text: 'Rs: ${expenses()}',
                          size: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            15.h.heightBox,
            /////////////////////////
            const Homebanner(),
          ],
        );
      },
    );
  }
}
