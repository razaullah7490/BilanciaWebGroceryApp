import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/processed_resource_action.dart';
import 'package:grocery/Presentation/views/home/inventory/inventory_view_model.dart';

import '../../../resources/assets.dart';
import '../../../resources/routes/navigation.dart';
import '../../../resources/routes/routes_names.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.inventoryText,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomSizedBox.height(15),
            Expanded(
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 25),
                    itemCount: InventoryViewModel.inventoryList.length,
                    itemBuilder: (context, index) {
                      var singleData = InventoryViewModel.inventoryList[index];
                      return buildGridContainer(context, singleData);
                    },
                  ),
                  CustomSizedBox.height(22),
                  proceedResourceGridContainer(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridContainer(
    BuildContext context,
    InventoryGridModel singleData,
  ) {
    return GestureDetector(
      onTap: () => Navigate.to(context, singleData.onTap),
      //Navigator.pushNamed(context, singleData.onTap),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6).r,
        decoration: BoxDecoration(
          color: singleData.backgroundColor,
          borderRadius: BorderRadius.circular(
            AppBorderRadius.dashboardGridContainerBorderRadius,
          ).r,
          border: Border.all(
            color: singleData.borderColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.p18,
                vertical: AppSize.p10,
              ).r,
              decoration: BoxDecoration(
                color: singleData.iconColor,
                borderRadius: BorderRadius.circular(
                  AppBorderRadius.dashboardContainerBorderRadius,
                ),
              ),
              child:
                  Image.asset(singleData.imageUrl, width: 50.w, height: 50.h),
            ),
            Text(
              singleData.name,
              textAlign: TextAlign.center,
              style: Styles.circularStdBook(
                AppSize.text14.sp,
                AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget proceedResourceGridContainer(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigate.to(context, const ProcessedResourceActionScreen()),
      // Navigator.pushNamed(
      //     context, RoutesNames.proceedResourceActionsScreen),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6).r,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p15,
          vertical: AppSize.p35,
        ).r,
        decoration: BoxDecoration(
          color: AppColors.dashContainerBack6,
          borderRadius: BorderRadius.circular(
            AppBorderRadius.dashboardGridContainerBorderRadius,
          ).r,
          border: Border.all(
            color: AppColors.dashContainerBorder6,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.p18,
                vertical: AppSize.p10,
              ).r,
              decoration: BoxDecoration(
                color: AppColors.dashContainerIcon6,
                borderRadius: BorderRadius.circular(
                  AppBorderRadius.dashboardContainerBorderRadius,
                ),
              ),
              child: Image.asset(
                Assets.processedResourceAction,
                width: 50.w,
                height: 50.h,
              ),
            ),
            Text(
              AppStrings.processedResourceActionText,
              textAlign: TextAlign.center,
              style: Styles.circularStdBook(
                AppSize.text14.sp,
                AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
