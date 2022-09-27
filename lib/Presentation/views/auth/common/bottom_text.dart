import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';

Widget bottomText(
  BuildContext context,
  String text,
  String buttonText,
  VoidCallback onTap,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text,
        style: Styles.segoeUI(
          AppSize.text15.sp,
          AppColors.blackColor,
        ),
      ),
      CustomSizedBox.width(10),
      Padding(
        padding: const EdgeInsets.only(top: AppSize.p12).r,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Text(
            buttonText,
            style: Styles.circularStdBook(
              AppSize.text17.sp,
              AppColors.primaryColor,
            ),
          ),
        ),
      ),
    ],
  );
}
