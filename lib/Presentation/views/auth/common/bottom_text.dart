import 'package:grocery/Application/exports.dart';

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
