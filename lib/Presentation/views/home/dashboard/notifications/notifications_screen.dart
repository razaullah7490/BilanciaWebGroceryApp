import 'package:grocery/Application/exports.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    Future.wait([
      context.read<NotificationCubit>().getNotifications(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.notificationsText,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: AppSize.p10).r,
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state.status == NotificationEnum.loading) {
              return const NotificationTileShimmerEffect();
            }
            return state.modelList.isEmpty
                ? DataNotAvailableText.withOutExpanded(
                    AppStrings.noNotificationText,
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.modelList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: dismissibleBackgroundContainer(),
                        onDismissed: (direction) {
                          context
                              .read<NotificationCubit>()
                              .editNotification(state.modelList[index].id);
                        },
                        key:
                            ValueKey<NotificationModel>(state.modelList[index]),
                        child: NotficationDetailContainer(
                            model: state.modelList[index]),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

  Widget dismissibleBackgroundContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSize.m8).r,
      padding: const EdgeInsets.symmetric(horizontal: 30).r,
      decoration: BoxDecoration(
        color: AppColors.dashContainerBorder4,
        borderRadius: BorderRadius.circular(
          AppBorderRadius.notificationDismissibleRadius.r,
        ),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: AppColors.whiteColor,
          size: AppSize.appBarIconSize.r,
        ),
      ),
    );
  }
}
