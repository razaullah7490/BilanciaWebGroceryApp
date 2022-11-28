import 'package:grocery/Application/exports.dart';

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
