import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/extensions/media_query_extension.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/assets.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';

class NoMoreEventsContainer extends StatelessWidget {
  const NoMoreEventsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQueryValues(context).height * 0.22,
      margin: const EdgeInsets.symmetric(horizontal: AppSize.m10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(
          AppBorderRadius.dashboardSliderBorderRadius.r,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(Assets.noMoreEventsImage),
          ),
          Center(
            child: Text(
              AppStrings.noUpcomingEventsYetText,
              textAlign: TextAlign.center,
              style: Styles.circularStdMedium(
                AppSize.text21.sp,
                AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
