import 'package:grocery/Application/exports.dart';
import 'package:intl/intl.dart' as intl;

// ignore: must_be_immutable
class CustomDatePickerWidget extends StatefulWidget {
  DateTime? date;
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
                widget.date != null
                    ? getHumanReadableDateAndTime(widget.date.toString())
                    : AppStrings.selectDateText,
                style: Styles.circularStdBook(
                    AppSize.text15.sp,
                    widget.date != null
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

  String getHumanReadableDateAndTime(String dt) {
    DateTime dateTime = DateTime.parse(dt);
    return intl.DateFormat('MMM dd, yyyy ').format(dateTime);
  }
}
