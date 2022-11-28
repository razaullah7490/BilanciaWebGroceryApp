import 'package:grocery/Application/exports.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.notificationText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p16).r,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedBox.height(30),
              titleText(),
              CustomSizedBox.height(15),
              notificationContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Container notificationContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.p18,
        vertical: AppSize.p8,
      ).r,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.secondaryColor, width: 1.w),
        borderRadius:
            BorderRadius.circular(AppBorderRadius.appBarContainerBorderRadius)
                .r,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          subTitleText(),
          switchButtonWidget(),
        ],
      ),
    );
  }

  Transform switchButtonWidget() {
    return Transform.scale(
      scale: 1.3,
      child: Switch(
        activeColor: AppColors.primaryColor,
        activeTrackColor: AppColors.switchInActiveColor,
        inactiveTrackColor: AppColors.switchInActiveColor,
        inactiveThumbColor: AppColors.primaryColor,
        value: isChecked,
        onChanged: (bool value) {
          setState(() {
            isChecked = value;
          });
        },
      ),
    );
  }

  Text subTitleText() {
    return Text(
      AppStrings.notificationText,
      style: Styles.circularStdBook(
        AppSize.text15.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Text titleText() {
    return Text(
      AppStrings.turnOnOffNotificationText,
      style: Styles.circularStdBook(
        AppSize.text17.sp,
        AppColors.containerTextColor,
      ),
    );
  }
}
