import 'package:grocery/Application/exports.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double scale;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 180.w * scale,
        height: 45.h * scale,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          border: Border.all(color: AppColors.secondaryColor, width: 1.w),
          borderRadius:
              BorderRadius.circular(AppBorderRadius.buttonBorderRadius).r,
        ),
        child: Center(
            child: Text(text,
                style: Styles.circularStdBook(
                  17.sp * scale,
                  AppColors.whiteColor,
                ))),
      ),
    );
  }
}
