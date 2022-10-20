import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/loading_indicator.dart';
import 'package:grocery/Presentation/resources/assets.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grocery/Presentation/views/home/dashboard/dashboard_view_model.dart';
import 'package:grocery/Presentation/views/home/dashboard/notifications/notifications_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../resources/routes/navigation.dart';

class DashBoardLargeAppBar extends StatefulWidget {
  const DashBoardLargeAppBar({super.key});

  @override
  State<DashBoardLargeAppBar> createState() => _DashBoardLargeAppBarState();
}

class _DashBoardLargeAppBarState extends State<DashBoardLargeAppBar> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        padding: const EdgeInsets.only(bottom: AppSize.p45).r,
        color: AppColors.appBarColor,
        child: Column(
          children: [
            topImageAndNotification("1"),
            CustomSizedBox.height(10),
            CarouselSlider.builder(
              itemCount: DashBoardViewModel.dashImages.length,
              options: CarouselOptions(
                height: 145.h,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                viewportFraction: 1,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              ),
              itemBuilder: (context, index, realIndex) {
                final urlImage = DashBoardViewModel.dashImages[index];
                return buildImage(urlImage, index);
              },
            ),
            CustomSizedBox.height(20),
            buildIndicator(),
          ],
        ),
      ),
    );
  }

  Widget topImageAndNotification(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.p15).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            Assets.appLogo,
            width: 95.w,
            height: 85.h,
            fit: BoxFit.fill,
          ),
          GestureDetector(
            onTap: () => Navigate.to(context, const NotificationScreen()),
            //Navigator.pushNamed(context, RoutesNames.notificationScreen),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  AppBorderRadius.appBarContainerBorderRadius,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: Icon(
                      Icons.notifications_none,
                      color: AppColors.hintTextColor,
                      size: AppSize.icon28.r,
                    ),
                  ),
                  Positioned(
                    top: 7,
                    right: 6,
                    child: Container(
                      width: 12.w,
                      height: 12.h,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: AppSize.notificationText8.sp,
                                color: AppColors.whiteColor)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: CachedNetworkImage(
          imageUrl: urlImage,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppBorderRadius.dashboardSliderBorderRadius,
              ),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => LoadingIndicator.loading(),
          errorWidget: (context, url, error) => Icon(Icons.error, size: 30.r),
        ),
      );

  buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: DashBoardViewModel.dashImages.length,
        effect: WormEffect(
          activeDotColor: AppColors.primaryColor,
          dotColor: AppColors.secondaryColor,
          dotHeight: 12.w,
          dotWidth: 12.w,
        ),
      );
}
