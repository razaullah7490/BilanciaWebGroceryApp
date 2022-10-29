import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:shimmer/shimmer.dart';
import '../../resources/border_radius.dart';
import 'package:grocery/Presentation/common/extensions/media_query_extension.dart';

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
