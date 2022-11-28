import 'package:grocery/Application/exports.dart';
import 'package:intl/intl.dart';

class DashBoardLargeAppBar extends StatefulWidget {
  const DashBoardLargeAppBar({super.key});

  @override
  State<DashBoardLargeAppBar> createState() => _DashBoardLargeAppBarState();
}

class _DashBoardLargeAppBarState extends State<DashBoardLargeAppBar> {
  int activeIndex = 0;
  @override
  void initState() {
    Future.wait([
      context.read<EventCubit>().getEvent(),
      context.read<TagsCubit>().getAllTags(),
      context.read<NotificationCubit>().getNotifications(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        padding: const EdgeInsets.only(bottom: AppSize.p45).r,
        color: AppColors.appBarColor,
        child: Column(
          children: [
            BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
              return appBar("${state.modelList.length}");
            }),
            CustomSizedBox.height(10),
            BlocBuilder<EventCubit, EventState>(builder: (context, state) {
              var tagModel = context.read<TagsCubit>().state.tagModel;
              //var eventModelLength = state.eventModel.length + 1;
              if (state.status == EventEnum.loading) {
                return const EventContainerShimmerEffect();
              }
              return state.eventModel.isEmpty
                  ? const NoMoreEventsContainer()
                  : Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: state.eventModel.length,
                          options: CarouselOptions(
                            height: 155.h,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            viewportFraction: 1,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (index, reason) =>
                                setState(() => activeIndex = index),
                          ),
                          itemBuilder: (context, index, realIndex) {
                            var model = state.eventModel[index];
                            var isContain =
                                tagModel.where((e) => e.id == model.eventTag);
                            var data = List<TagModel>.from(isContain);
                            var color =
                                isContain.map((e) => e.color).toString();
                            var splitColor =
                                color.substring(1, color.length - 1);
                            return buildEventContainer(
                              model: model,
                              isContain: data,
                              color: splitColor,
                            );
                          },
                        ),
                        CustomSizedBox.height(20),
                        buildIndicator(state.eventModel.length),
                      ],
                    );
            }),
          ],
        ),
      ),
    );
  }

  Container loading(BuildContext context) {
    return Container(
      height: MediaQueryValues(context).height * 0.22,
      margin: const EdgeInsets.symmetric(horizontal: AppSize.m10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(
          AppBorderRadius.dashboardSliderBorderRadius.r,
        ),
      ),
      child: Center(
        child: LoadingAnimationWidget.inkDrop(
          color: AppColors.whiteColor,
          size: 30.r,
        ),
      ),
    );
  }

  Widget appBar(String text) {
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
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigate.to(context, const AllTagsScreen()),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 40.w,
                  height: 40.w,
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
                  child: Center(
                    child: Icon(
                      Icons.local_offer_outlined,
                      color: AppColors.primaryColor,
                      size: AppSize.icon25.r,
                    ),
                  ),
                ),
              ),
              CustomSizedBox.width(10),
              GestureDetector(
                onTap: () => Navigate.to(context, const AllEventsScreen()),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 40.w,
                  height: 40.w,
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
                  child: Center(
                    child: Image.asset(
                      Assets.eventImage,
                      color: AppColors.primaryColor,
                      width: 27.w,
                      height: 27.w,
                    ),
                  ),
                ),
              ),
              CustomSizedBox.width(10),
              GestureDetector(
                onTap: () => Navigate.to(context, const NotificationScreen()),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 40.w,
                  height: 40.w,
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
                          size: AppSize.icon25.r,
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
        ],
      ),
    );
  }

  Widget buildEventContainer({
    required EventModel model,
    required List<TagModel> isContain,
    required String color,
  }) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSize.m10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.primaryColor.withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(
            AppBorderRadius.dashboardSliderBorderRadius.r,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppSize.p10).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSizedBox.height(8.h),
                        titleText(model.title),
                        descriptionText(model.description),
                        CustomSizedBox.height(8.h),
                        participantsText(model.participants.length.toString()),
                        CustomSizedBox.height(2.h),
                        Row(
                          children: [
                            isContain.isEmpty
                                ? Image.asset(
                                    Assets.noTagImage,
                                    width: 18.w,
                                    height: 18.h,
                                  )
                                : Opacity(
                                    opacity: 0.6,
                                    child: Image.asset(
                                      Assets.tagImage,
                                      width: 18.w,
                                      height: 18.h,
                                      color: ColorExtension(color).toColor(),
                                    ),
                                  ),
                            CustomSizedBox.width(8.h),
                            isContain.isEmpty
                                ? const Text("")
                                : tagText(
                                    isContain
                                        .map((e) => e.name)
                                        .toString()
                                        .substring(
                                            1,
                                            isContain
                                                    .map((e) => e.name)
                                                    .toString()
                                                    .length -
                                                1),
                                    ColorExtension(color).toColor()),
                          ],
                        ),
                        CustomSizedBox.height(5.h),
                      ],
                    ),
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
            dateAndTimeText(
                "${getHumanReadableDateAndTime(model.beginDate)} TO ${getHumanReadableDateAndTime(model.endDate)}"),
          ],
        ),
      );

  Text dateAndTimeText(String text) {
    return Text(
      text,
      style: Styles.circularStdBook(
        AppSize.text13.sp,
        AppColors.whiteColor,
      ),
    );
  }

  Text tagText(String text, Color color) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Styles.segoeUI(
        AppSize.text14.sp,
        color,
      ),
    );
  }

  RichText participantsText(String text) {
    return RichText(
      text: TextSpan(
          text: "${AppStrings.participantsText}: ",
          style:
              Styles.circularStdMedium(AppSize.text15.sp, AppColors.whiteColor),
          children: [
            TextSpan(
              text: text,
              style: Styles.circularStdBook(
                AppSize.text14.sp,
                AppColors.whiteColor,
              ),
            )
          ]),
    );
  }

  Text titleText(String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Styles.circularStdMedium(
        AppSize.text20.sp,
        AppColors.whiteColor,
      ),
    );
  }

  Text descriptionText(String text) {
    return Text(text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: "Circular Std Book",
          fontSize: AppSize.text14.sp,
          color: AppColors.whiteColor,
          fontStyle: FontStyle.italic,
        ));
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

  buildIndicator(length) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: length,
        effect: WormEffect(
          activeDotColor: AppColors.primaryColor,
          dotColor: AppColors.secondaryColor,
          dotHeight: 12.w,
          dotWidth: 12.w,
        ),
      );

  String getHumanReadableDateAndTime(dt) {
    DateTime dateTime = DateTime.parse(dt);
    return DateFormat('MMM dd,').add_jm().format(dateTime);
  }
}
