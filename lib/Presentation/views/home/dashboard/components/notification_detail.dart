import 'package:grocery/Application/exports.dart';
import 'package:intl/intl.dart';

class NotficationDetailContainer extends StatelessWidget {
  final NotificationModel model;
  const NotficationDetailContainer({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.p15,
        vertical: AppSize.p14,
      ).r,
      margin: const EdgeInsets.symmetric(
              horizontal: AppSize.p16, vertical: AppSize.m8)
          .r,
      decoration: BoxDecoration(
        color: AppColors.dashContainerBack4,
        border: Border.all(
          color: AppColors.dashContainerBorder4,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(
          AppBorderRadius.notificationParentContainerRadius.r,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 63.w,
            height: 63.w,
            decoration: BoxDecoration(
              color: AppColors.dashContainerIcon4,
              borderRadius: BorderRadius.circular(
                AppBorderRadius.notificationchildContainerRadius.r,
              ),
            ),
            child: Center(
              child: Image.asset(
                Assets.notification,
                width: 26.w,
                height: 26.h,
              ),
            ),
          ),
          CustomSizedBox.width(12),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomSizedBox.height(2),
                titleText(model.title),
                subTitleText(model.message),
                CustomSizedBox.height(2),
                Align(
                  alignment: Alignment.bottomRight,
                  child: dateTimeText(getDateTime(model.dateTime)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Styles.circularStdMedium(
        AppSize.text14.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Widget subTitleText(String text) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Styles.circularStdBook(
        AppSize.text13.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Widget dateTimeText(String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Styles.circularStdBook(
        AppSize.text12.sp,
        AppColors.hintTextColor,
      ),
    );
  }

  String getDateTime(dt) {
    DateTime dateTime = DateTime.parse(dt);
    return DateFormat('MMM dd,yyy').add_jm().format(dateTime);
  }
}
