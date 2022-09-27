import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/assets.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';

class NotficationDetailContainer extends StatelessWidget {
  const NotficationDetailContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.p15,
        vertical: AppSize.p12,
      ).r,
      margin: const EdgeInsets.symmetric(
              horizontal: AppSize.p16, vertical: AppSize.m8)
          .r,
      decoration: BoxDecoration(
        color: AppColors.dashContainerBack4,
        border: Border.all(
          color: AppColors.dashContainerBorder4,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(
          AppBorderRadius.notificationParentContainerRadius.r,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppColors.dashContainerIcon4,
              borderRadius: BorderRadius.circular(
                AppBorderRadius.notificationchildContainerRadius.r,
              ),
            ),
            child: Center(
              child: Image.asset(
                Assets.notification,
                width: 26.w,
                height: 26.h,
              ),
            ),
          ),
          CustomSizedBox.width(12),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleText("Welcome to Baliancia Web!!!"),
                CustomSizedBox.height(2),
                subTitleText(
                    "Explore the best grocery inventory at our platform"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Styles.circularStdMedium(
        AppSize.text14.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Widget subTitleText(String text) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Styles.circularStdBook(
        AppSize.text13.sp,
        AppColors.containerTextColor,
      ),
    );
  }
}
