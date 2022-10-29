import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:shimmer/shimmer.dart';
import '../../resources/border_radius.dart';

class ProductListTileShimmerEffect extends StatelessWidget {
  const ProductListTileShimmerEffect({Key? key}) : super(key: key);

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
          horizontal: AppSize.p16,
          vertical: AppSize.p12,
        ).r,
        margin: const EdgeInsets.symmetric(
          vertical: AppSize.m6,
          horizontal: AppSize.m10,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 70.w,
                  height: 67.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      width: 1.w,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 50.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          width: 1.w,
                        ),
                      ),
                    ),
                  ),
                ),
                CustomSizedBox.width(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 120.w,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    CustomSizedBox.height(10),
                    Container(
                      width: 95.w,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    CustomSizedBox.height(4),
                    Container(
                      width: 75.w,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: 9.w,
              height: 23.h,
              padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.p15, vertical: 7)
                  .r,
              decoration: BoxDecoration(
                border: Border.all(width: 1.w),
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
          ],
        ),
      );
}
