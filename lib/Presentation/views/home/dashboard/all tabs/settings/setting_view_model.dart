import 'package:grocery/Application/exports.dart';

import 'DeleteScreens/delete_screen.dart';

class SettingViewModel {
  static List<SettingGridModel> settingList = [
    SettingGridModel(
      imageUrl: Assets.commandImage,
      name: AppStrings.commandText,
      backgroundColor: Colors.purple.withOpacity(0.1),
      iconColor: Colors.purple.withOpacity(0.11),
      borderColor: Colors.purple.withOpacity(0.1),
      onTap: const CommandScreen(),
    ),
    SettingGridModel(
      imageUrl: Assets.editProfile,
      name: AppStrings.editProfileText,
      backgroundColor: AppColors.dashContainerBack1,
      iconColor: AppColors.dashContainerIcon1,
      borderColor: AppColors.dashContainerBorder1,
      onTap: const EditProfileScreen(),
    ),
    SettingGridModel(
      imageUrl: Assets.changePassword,
      name: AppStrings.changePasswordText,
      backgroundColor: AppColors.changePasswordFillColor,
      iconColor: AppColors.dashContainerBack5,
      borderColor: AppColors.changePasswordborderColor,
      onTap: const ChangePasswordScreen(),
    ),
    SettingGridModel(
      imageUrl: Assets.deleteIcon,
      name: "Eliminare l'account",
      backgroundColor: AppColors.changePasswordFillColor,
      iconColor: AppColors.dashContainerBack5,
      borderColor: AppColors.changePasswordborderColor,
      onTap: const DeleteInfo(),
    ),
    // SettingGridModel(
    //   imageUrl: Assets.settingNotification,
    //   name: AppStrings.notificationsText,
    //   backgroundColor: AppColors.notificationFillColor,
    //   iconColor: AppColors.notificationborderColor,
    //   borderColor: AppColors.notificationborderColor,
    //   onTap: const NotificationSettingScreen(),
    // ),
  ];
}

class SettingGridModel {
  String imageUrl;
  String name;
  Color backgroundColor;
  Color iconColor;
  Color borderColor;
  Widget onTap;

  SettingGridModel({
    required this.imageUrl,
    required this.name,
    required this.backgroundColor,
    required this.iconColor,
    required this.borderColor,
    required this.onTap,
  });
}
