import 'package:grocery/Application/exports.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.inventoryText,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQueryValues(context).height,
          width: MediaQueryValues(context).width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomSizedBox.height(15),
                categoryGridContainer(context),
                CustomSizedBox.height(20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 25),
                  itemCount: InventoryViewModel.inventoryList.length,
                  itemBuilder: (context, index) {
                    var singleData = InventoryViewModel.inventoryList[index];
                    return FadeAnimation(
                        delay: index.toDouble(),
                        child: buildGridContainer(context, singleData));
                  },
                ),
                CustomSizedBox.height(20),
              ],
            ),
          ),
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

  // Widget proceedResourceGridContainer(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () => Navigate.to(context, const ProcessedResourceActionScreen()),
  //     behavior: HitTestBehavior.opaque,
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 6).r,
  //       padding: const EdgeInsets.symmetric(
  //         horizontal: AppSize.p15,
  //         vertical: AppSize.p35,
  //       ).r,
  //       decoration: BoxDecoration(
  //         color: AppColors.dashContainerBack6,
  //         borderRadius: BorderRadius.circular(
  //           AppBorderRadius.dashboardGridContainerBorderRadius,
  //         ).r,
  //         border: Border.all(
  //           color: AppColors.dashContainerBorder6,
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.symmetric(
  //               horizontal: AppSize.p18,
  //               vertical: AppSize.p10,
  //             ).r,
  //             decoration: BoxDecoration(
  //               color: AppColors.dashContainerIcon6,
  //               borderRadius: BorderRadius.circular(
  //                 AppBorderRadius.dashboardContainerBorderRadius,
  //               ),
  //             ),
  //             child: Image.asset(
  //               Assets.processedResourceAction,
  //               width: 50.w,
  //               height: 50.h,
  //             ),
  //           ),
  //           Text(
  //             AppStrings.processedResourceActionText,
  //             textAlign: TextAlign.center,
  //             style: Styles.circularStdBook(
  //               AppSize.text14.sp,
  //               AppColors.blackColor,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget categoryGridContainer(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigate.to(context, const CategoryScreen()),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6).r,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p40,
          vertical: AppSize.p32,
        ).r,
        decoration: BoxDecoration(
          color: AppColors.dashContainerBack2,
          borderRadius: BorderRadius.circular(
            AppBorderRadius.dashboardGridContainerBorderRadius,
          ).r,
          border: Border.all(
            color: AppColors.dashContainerBorder2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.p18,
                vertical: AppSize.p10,
              ).r,
              decoration: BoxDecoration(
                color: AppColors.dashContainerIcon2,
                borderRadius: BorderRadius.circular(
                  AppBorderRadius.dashboardContainerBorderRadius,
                ),
              ),
              child: Image.asset(
                Assets.categories,
                width: 50.w,
                height: 50.h,
              ),
            ),
            CustomSizedBox.width(20),
            Text(
              AppStrings.categoriesText,
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
