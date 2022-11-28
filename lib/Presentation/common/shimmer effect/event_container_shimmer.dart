import 'package:grocery/Application/exports.dart';

class EventContainerShimmerEffect extends StatelessWidget {
  const EventContainerShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: AppColors.secondaryColor,
      highlightColor: Colors.grey[100]!,
      child: placeHolderRow(context),
    );
  }

  Widget placeHolderRow(BuildContext context) => Container(
        height: MediaQueryValues(context).height * 0.22,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: AppSize.m10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppBorderRadius.dashboardSliderBorderRadius.r,
          ),
        ),
      );
}
