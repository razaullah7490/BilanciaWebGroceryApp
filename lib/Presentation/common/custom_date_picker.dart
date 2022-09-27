import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import '../resources/app_strings.dart';
import '../resources/border_radius.dart';
import '../resources/size.dart';
import '../resources/text_styles.dart';

// ignore: must_be_immutable
class CustomDatePickerWidget extends StatefulWidget {
  String date;
  VoidCallback onTap;
  CustomDatePickerWidget({
    super.key,
    required this.onTap,
    required this.date,
  });

  @override
  State<CustomDatePickerWidget> createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
              child: Text(
                widget.date.isNotEmpty
                    ? widget.date
                    : AppStrings.selectDateText,
                style: Styles.circularStdBook(
                    AppSize.text15.sp,
                    widget.date.isNotEmpty
                        ? AppColors.containerTextColor
                        : AppColors.hintTextColor),
              ),
            ),
            const Icon(
              Icons.calendar_month,
              color: AppColors.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
