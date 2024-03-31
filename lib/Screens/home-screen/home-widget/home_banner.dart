import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Constants/ColorConstants.dart';
import '../../../Controllers/banner_controller.dart';

class Homebanner extends StatelessWidget {
  const Homebanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BannerController bannerController = Get.put(BannerController());

    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Obx(() {
        return CarouselSlider(
          items: bannerController.bannerUrls.map((imageUrls) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: imageUrls,
                fit: BoxFit.cover,
                placeholder: (context, url) => const ColoredBox(
                  color: Colors.white,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            scrollDirection: Axis.horizontal,
            autoPlay: true,
            aspectRatio: 2.5,
            viewportFraction: 1,
          ),
        );
      }),
    );
  }
}
