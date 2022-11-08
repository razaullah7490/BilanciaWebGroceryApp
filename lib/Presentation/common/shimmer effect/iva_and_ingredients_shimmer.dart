import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:shimmer/shimmer.dart';
import '../../resources/border_radius.dart';

class IvaAndIngredientShimmerEffect extends StatelessWidget {
  const IvaAndIngredientShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: AppSize.p2).r,
          child: placeHolderRow(),
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 2),
      ),
    );
  }

  Widget placeHolderRow() => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p18,
          vertical: AppSize.p15,
        ).r,
        margin: const EdgeInsets.symmetric(
          vertical: AppSize.m4,
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
            Row(
              children: [
                Container(
                  width: 80.w,
                  height: 8.0,
                  color: Colors.white,
                ),
                CustomSizedBox.width(5),
                Container(
                  width: 40.w,
                  height: 8.0,
                  color: Colors.white,
                ),
              ],
            ),
            Container(
              width: 55.w,
              height: 21.h,
              decoration: BoxDecoration(
                border: Border.all(width: 1.w),
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
          ],
        ),
      );
}
