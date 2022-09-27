import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';

class DataNotAvailableText {
  static Widget withExpanded(String text) {
    return Expanded(
      child: Center(
          child: Text(
        text,
        textAlign: TextAlign.center,
        style: Styles.circularStdMedium(
          AppSize.text20.sp,
          AppColors.redColor2,
        ),
      )),
    );
  }

  static Widget withOutExpanded(String text) {
    return Center(
        child: Text(
      text,
      style: Styles.circularStdMedium(
        AppSize.text20.sp,
        AppColors.redColor2,
      ),
    ));
  }
}
