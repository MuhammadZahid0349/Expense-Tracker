// ignore_for_file: unnecessary_string_escapes, must_be_immutable, unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expense_tracker/Constants/ColorConstants.dart';
import 'package:expense_tracker/Constants/ImagesPath.dart';
import 'package:expense_tracker/Constants/utils.dart';
import 'package:expense_tracker/Screens/home-screen/home-widget/home_banner.dart';
import 'package:expense_tracker/Screens/home-screen/home-widget/home_head.dart';
import 'package:expense_tracker/data/model/add_date.dart';
import 'package:expense_tracker/data/utlity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Controllers/banner_controller.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  var history;

  final box = Hive.box<Add_data>('data');

  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, value, child) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child:
                      SizedBox(height: 400.h, child: const HomeHeadContainer()),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customizedText(
                            text: 'Transactions History',
                            size: 18.sp,
                            color: black,
                            fontWeight: FontWeight.w700),
                        customizedText(
                            text: 'See all',
                            size: 15.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      history = box.values.toList()[index];
                      return getList(history, index);
                    },
                    childCount: box.length,
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget getList(Add_data history, int index) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          history.delete();
        },
        child: get(index, history));
  }

  ListTile get(int index, Add_data history) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('images/${history.name}.png', height: 40),
      ),
      title: Text(
        history.name,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${day[history.datetime.weekday - 1]}  ${history.datetime.year}-${history.datetime.day}-${history.datetime.month}',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        history.amount,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 19,
          color: history.IN == 'Income' ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
