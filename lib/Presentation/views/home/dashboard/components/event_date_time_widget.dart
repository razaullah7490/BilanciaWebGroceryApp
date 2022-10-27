import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../resources/border_radius.dart';
import '../../../../resources/colors_palette.dart';
import '../../../../resources/size.dart';
import '../../../../resources/text_styles.dart';

class EventDateTimePicker {
  static Widget datePickerWidget({
    required VoidCallback onTap,
    required Widget textWidget,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.only(
                left: AppSize.p12,
                right: AppSize.p22,
                top: AppSize.p14,
                bottom: AppSize.p14)
            .r,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.secondaryColor,
            width: 1.w,
          ),
          borderRadius:
              BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppSize.p2).r,
              child: textWidget,
            ),
            const Icon(
              Icons.calendar_month,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  static Future<DateTime?> pickDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor,
              ),
            ),
            child: child!,
          );
        },
      );

  static Future<TimeOfDay?> pickTime(BuildContext context) => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor,
              ),
            ),
            child: child!,
          );
        },
      );
}
