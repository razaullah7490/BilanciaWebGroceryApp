import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import '../resources/assets.dart';
import '../resources/colors_palette.dart';
import '../resources/size.dart';

class NotFoundWidget extends StatelessWidget {
  final String text;
  const NotFoundWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assets.notFoundImage,
            color: AppColors.primaryColor,
            width: 180.w,
            height: 115.h,
            fit: BoxFit.fill,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Styles.circularStdMedium(
              AppSize.text20.sp,
              AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
