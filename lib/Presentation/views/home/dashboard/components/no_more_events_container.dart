import 'package:grocery/Application/exports.dart';

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
