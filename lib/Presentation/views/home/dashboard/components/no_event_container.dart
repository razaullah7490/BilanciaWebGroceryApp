import 'package:grocery/Application/exports.dart';

class NoEventContainer extends StatelessWidget {
  const NoEventContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQueryValues(context).height * 0.22,
      margin: const EdgeInsets.symmetric(horizontal: AppSize.m10),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.p14,
        vertical: AppSize.p12,
      ).r,
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Order\nGroceries\nOnline",
                  style: Styles.circularStdMedium(
                    22.sp,
                    AppColors.primaryColor,
                  ),
                ),
                CustomSizedBox.height(5),
                Text(
                  "Save time We'll do the shopping for you",
                  style: Styles.circularStdBook(
                    17.sp,
                    AppColors.primaryColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            Assets.dashNewImage,
            width: 135.w,
            height: 110.h,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
