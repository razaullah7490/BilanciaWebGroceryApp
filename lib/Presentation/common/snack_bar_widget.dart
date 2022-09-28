import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';

class SnackBarWidget {
  static buildSnackBar(
    BuildContext context,
    String message,
    Color color,
    IconData icon,
    bool isFloating,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Wrap(
        direction: Axis.horizontal,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 22.r,
          ),
          CustomSizedBox.width(5),
          Text(
            message,
            textAlign: TextAlign.start,
            style: Styles.segoeUI(
              AppSize.text14.sp,
              AppColors.whiteColor,
            ),
          ),
        ],
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 1),
      behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
    ));
  }
}
