import 'package:flutter/material.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/assets.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/category_screen.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/proceedResource/proceed_resource_screen.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/resource_actions_screen.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resources/resources_screen.dart';

class InventoryViewModel {
  static List<InventoryGridModel> inventoryList = [
    // InventoryGridModel(
    //   imageUrl: Assets.products,
    //   name: AppStrings.productsText,
    //   backgroundColor: AppColors.dashContainerBack1,
    //   iconColor: AppColors.dashContainerIcon1,
    //   borderColor: AppColors.dashContainerBorder1,
    //   onTap: RoutesNames.productsScreen,
    // ),
    InventoryGridModel(
      imageUrl: Assets.categories,
      name: AppStrings.categoriesText,
      backgroundColor: AppColors.dashContainerBack2,
      iconColor: AppColors.dashContainerIcon2,
      borderColor: AppColors.dashContainerBorder2,
      onTap: const CategoryScreen(),
    ),
    InventoryGridModel(
      imageUrl: Assets.resources,
      name: AppStrings.resourcesText,
      backgroundColor: AppColors.dashContainerBack3,
      iconColor: AppColors.dashContainerIcon3,
      borderColor: AppColors.dashContainerBorder3,
      onTap: const ResorucesScreen(),
    ),
    InventoryGridModel(
      imageUrl: Assets.resourceActions,
      name: AppStrings.resourceActionText,
      backgroundColor: AppColors.dashContainerBack4,
      iconColor: AppColors.dashContainerIcon4,
      borderColor: AppColors.dashContainerBorder4,
      onTap: const ResourceActionsScreen(),
    ),
    InventoryGridModel(
      imageUrl: Assets.processedResource,
      name: AppStrings.processedResourceText,
      backgroundColor: AppColors.dashContainerBack5,
      iconColor: AppColors.dashContainerIcon5,
      borderColor: AppColors.dashContainerBorder5,
      onTap: const ProceedResourceScreen(),
    ),
    // InventoryGridModel(
    //   imageUrl: Assets.processedResourceAction,
    //   name: AppStrings.processedResourceActionText,
    //   backgroundColor: AppColors.dashContainerBack6,
    //   iconColor: AppColors.dashContainerIcon6,
    //   borderColor: AppColors.dashContainerBorder6,
    //   onTap: RoutesNames.proceedResourceActionsScreen,
    // ),
  ];
}

class InventoryGridModel {
  String imageUrl;
  String name;
  Color backgroundColor;
  Color iconColor;
  Color borderColor;
  Widget onTap;

  InventoryGridModel({
    required this.imageUrl,
    required this.name,
    required this.backgroundColor,
    required this.iconColor,
    required this.borderColor,
    required this.onTap,
  });
}
