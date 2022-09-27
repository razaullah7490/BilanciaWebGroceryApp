import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 180.w,
        height: 45.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          border: Border.all(color: AppColors.secondaryColor, width: 1.w),
          borderRadius:
              BorderRadius.circular(AppBorderRadius.buttonBorderRadius).r,
        ),
        child: Center(
            child: Text(text,
                style: Styles.circularStdBook(
                  17.sp,
                  AppColors.whiteColor,
                ))),
      ),
    );
  }
}
