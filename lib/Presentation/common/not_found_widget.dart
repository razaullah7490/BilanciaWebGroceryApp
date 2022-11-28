import 'package:grocery/Application/exports.dart';

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
