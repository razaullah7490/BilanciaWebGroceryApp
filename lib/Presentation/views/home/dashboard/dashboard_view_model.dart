import 'package:flutter/material.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/assets.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';

class DashBoardViewModel {
  static List<String> dashImages = [
    "https://hips.hearstapps.com/hmg-prod/images/healthy-groceries-1525213305.jpg",
    "https://img.freepik.com/premium-photo/shopping-basket-full-food-groceries-table-supermarket_8087-1865.jpg?w=2000",
    "https://media.istockphoto.com/photos/all-your-necessities-stored-in-one-place-picture-id1157106624?k=20&m=1157106624&s=612x612&w=0&h=jLXRK4qRL_3QITpschx1Wy2Aj2Vyy47Q1Q_R7hVcPQg=",
  ];

  static List<DashBoardGridModel> dashBoardList = [
    DashBoardGridModel(
      imageUrl: Assets.manageProducts,
      name: AppStrings.manageProductText,
      backgroundColor: AppColors.dashContainerBack1,
      iconColor: AppColors.dashContainerIcon1,
      borderColor: AppColors.dashContainerBorder1,
      onTap: RoutesNames.manageProductsScreen,
    ),
    DashBoardGridModel(
      imageUrl: Assets.inventory,
      name: AppStrings.inventoryText,
      backgroundColor: AppColors.dashContainerBack2,
      iconColor: AppColors.dashContainerIcon2,
      borderColor: AppColors.dashContainerBorder2,
      onTap: RoutesNames.inventoryScreen,
    ),
    DashBoardGridModel(
      imageUrl: Assets.setting,
      name: AppStrings.settingText,
      backgroundColor: AppColors.dashContainerBack3,
      iconColor: AppColors.dashContainerIcon3,
      borderColor: AppColors.dashContainerBorder3,
      onTap: RoutesNames.settingScreen,
    ),
    DashBoardGridModel(
      imageUrl: Assets.webPortal,
      name: AppStrings.webPortalText,
      backgroundColor: AppColors.dashContainerBack4,
      iconColor: AppColors.dashContainerIcon4,
      borderColor: AppColors.dashContainerBorder4,
      onTap: "",
    ),
  ];
}

class DashBoardGridModel {
  String imageUrl;
  String name;
  Color backgroundColor;
  Color iconColor;
  Color borderColor;
  String onTap;

  DashBoardGridModel({
    required this.imageUrl,
    required this.name,
    required this.backgroundColor,
    required this.iconColor,
    required this.borderColor,
    required this.onTap,
  });
}
