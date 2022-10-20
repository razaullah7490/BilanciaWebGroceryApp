import 'package:flutter/material.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/assets.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/changePassword/change_password_screen.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/editProfile/edit_profile_screen.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/notificationSetting/notification_setting.dart';

class SettingViewModel {
  static List<SettingGridModel> settingList = [
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
      imageUrl: Assets.settingNotification,
      name: AppStrings.notificationsText,
      backgroundColor: AppColors.notificationFillColor,
      iconColor: AppColors.notificationborderColor,
      borderColor: AppColors.notificationborderColor,
      onTap: const NotificationSettingScreen(),
    ),
    // SettingGridModel(
    //   imageUrl: Assets.logout,
    //   name: AppStrings.logOutText,
    //   backgroundColor: AppColors.addProductContainerColor,
    //   iconColor: AppColors.logoutborderColor,
    //   borderColor: AppColors.logoutborderColor,
    //   onTap: "",
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
