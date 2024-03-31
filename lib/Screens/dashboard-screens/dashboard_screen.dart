import 'package:expense_tracker/Constants/ColorConstants.dart';
import 'package:expense_tracker/Controllers/dashboard_controller.dart';
import 'package:expense_tracker/Screens/add.dart';
import 'package:expense_tracker/Screens/home-screen/home.dart';
import 'package:expense_tracker/Screens/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DashBoardController dashBoardController = Get.put(DashBoardController());
    List screens = [Home(), const Statistics()];
    return Scaffold(
      body: Obx(() => screens[dashBoardController.index.value]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const Add_Screen());
        },
        backgroundColor: MColor,
        child: Icon(
          Icons.add,
          size: 28.sp,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
            padding: const EdgeInsets.only(
                top: 7.5, bottom: 7.5, left: 25.0, right: 25.0),
            child: Obx(
              () => Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      dashBoardController.changeIndex(0);
                    },
                    child: Icon(
                      Icons.home,
                      size: 30.sp,
                      color: dashBoardController.index.value == 0
                          ? MColor
                          : Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      dashBoardController.changeIndex(1);
                    },
                    child: Icon(
                      Icons.bar_chart_outlined,
                      size: 30.sp,
                      color: dashBoardController.index.value == 1
                          ? MColor
                          : Colors.grey,
                    ),
                  ),
                  10.w.widthBox,
                ],
              ),
            )),
      ),
    );
  }
}
