import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:shimmer/shimmer.dart';
import '../../resources/border_radius.dart';

class CommandShimmerEffect extends StatelessWidget {
  const CommandShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(AppSize.p10).r,
        children: [
          Shimmer.fromColors(
            enabled: true,
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 7,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: AppSize.p8).r,
                child: placeHolderRow(),
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget placeHolderRow() => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p18,
          vertical: AppSize.p15,
        ).r,
        margin: const EdgeInsets.symmetric(
          vertical: AppSize.m8,
          horizontal: AppSize.m8,
        ).r,
        decoration: BoxDecoration(
          border: Border.all(width: 1.w),
          borderRadius:
              BorderRadius.circular(AppBorderRadius.allDetailContainerRadius.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBox.height(5),
                Container(
                  width: 170.w,
                  height: 8.0,
                  color: Colors.white,
                ),
                CustomSizedBox.height(4),
                Container(
                  width: 120.w,
                  height: 8.0,
                  color: Colors.white,
                ),
                CustomSizedBox.height(10),
                Container(
                  width: 60.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.categoryStatusRadius,
                    ).r,
                    border: Border.all(width: 1.w),
                  ),
                ),
              ],
            ),
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                border: Border.all(width: 1.w),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Center(
                child: Container(
                  width: 17.w,
                  height: 17.h,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
