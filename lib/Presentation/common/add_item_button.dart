import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';

Widget addItemButtonWidget({
  required BuildContext context,
  required String text,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSize.m10).r,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.p18,
            vertical: AppSize.p15,
          ).r,
          decoration: BoxDecoration(
            color: AppColors.addProductContainerColor,
            borderRadius:
                BorderRadius.circular(AppBorderRadius.searchTextFieldRadius.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.add,
                size: AppSize.plusIconSize.r,
              ),
              CustomSizedBox.width(5),
              Text(
                text,
                style: Styles.circularStdBook(
                  AppSize.text13.sp,
                  AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
