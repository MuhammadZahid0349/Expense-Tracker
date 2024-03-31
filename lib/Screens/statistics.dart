import 'package:expense_tracker/Constants/ColorConstants.dart';
import 'package:expense_tracker/Constants/utils.dart';
import 'package:expense_tracker/data/utlity.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Constants/ImagesPath.dart';
import '../data/model/add_date.dart';
import '../data/top.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

ValueNotifier kj = ValueNotifier(0);

class _StatisticsState extends State<Statistics> {
  List day = ['Day', 'Week', 'Month', 'Year'];
  List f = [today(), week(), month(), year()];
  List<Add_data> a = [];
  int index_color = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: customizedText(
          text: 'Statistics',
          color: Colors.white,
          size: 20.sp,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: MColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
                height: 40.h,
                width: 40.w,
                padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 8.w),
                decoration:
                    const BoxDecoration(color: white, shape: BoxShape.circle),
                child: Image.asset(AssetsPathImages.logo)),
          )
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: kj,
          builder: (BuildContext context, dynamic value, Widget? child) {
            a = f[value];
            return custom();
          },
        ),
      ),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              5.h.heightBox,
              const Divider(
                color: MColor,
              ),
              20.h.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      4,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              index_color = index;
                              kj.value = index;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color:
                                  index_color == index ? MColor : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: customizedText(
                              text: day[index],
                              color: index_color == index
                                  ? Colors.white
                                  : Colors.black,
                              size: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              20.h.heightBox,
              Chart(
                indexx: index_color,
              ),
              20.h.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customizedText(
                        text: 'Top Spending',
                        color: Colors.black,
                        size: 16.sp,
                        fontWeight: FontWeight.bold),
                    Icon(
                      Icons.swap_vert,
                      size: 25.sp,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset('images/${a[index].name}.png', height: 40),
              ),
              title: customizedText(
                text: a[index].name,
                size: 17.sp,
                fontWeight: FontWeight.w600,
              ),
              subtitle: customizedText(
                text:
                    ' ${a[index].datetime.year}-${a[index].datetime.day}-${a[index].datetime.month}',
                fontWeight: FontWeight.w600,
              ),
              trailing: customizedText(
                text: a[index].amount,
                fontWeight: FontWeight.w600,
                size: 19.sp,
                color: a[index].IN == 'Income' ? Colors.green : Colors.red,
              ),
            );
          },
          childCount: a.length,
        ))
      ],
    );
  }
}
