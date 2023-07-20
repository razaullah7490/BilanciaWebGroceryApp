import 'package:grocery/Application/exports.dart';

class ResourceDetailContainer extends StatelessWidget {
  final ResourcesModel model;
  const ResourceDetailContainer({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.p18,
        vertical: AppSize.p15,
      ).r,
      margin: const EdgeInsets.symmetric(
        vertical: AppSize.m8,
        horizontal: AppSize.m8,
      ).r,
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        border: Border.all(
          color: AppColors.containerBorderColor,
          width: 1.w,
        ),
        borderRadius:
            BorderRadius.circular(AppBorderRadius.allDetailContainerRadius.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBox.height(5),
                titleText(model.resourceName),
                CustomSizedBox.height(5),
                subTitleText("${AppStrings.aliquotaIVAText} :",
                    model.aliquotaIva.toString()),
                subTitleText(
                    "${AppStrings.categoryText} :", model.category.toString()),
                subTitleText("${AppStrings.quantityOnlyText} :",
                    model.stockQuantity.toString()),
                CustomSizedBox.height(2),
                salePriceText(model.unitSalePrice.toString()),
                model.isDeleted == true
                    ? Padding(
                        padding: const EdgeInsets.only(top: AppSize.p6).r,
                        child: Text(AppStrings.resourceDeleteInText,
                            style: Styles.segoeUI(
                              AppSize.text10.sp,
                              AppColors.redColor2,
                            )),
                      )
                    : Container()
              ],
            ),
          ),
          editDeleteIcons(
            onTapEdit: () {
              final args = ResourcesModel(
                resourceId: model.resourceId,
                resourceName: model.resourceName,
                aliquotaIva: model.aliquotaIva,
                ivaType: model.ivaType,
                stockQuantity: model.stockQuantity,
                stockQuantityThreshold: model.stockQuantityThreshold,
                measureUnit: model.measureUnit,
                barCode: model.barCode,
                plu: model.plu,
                shelfLife: model.shelfLife,
                unitSalePrice: model.unitSalePrice,
                revenuePercentage: model.revenuePercentage,
                category: model.category,
                tare: model.tare,
                weightType: model.weightType,
                packagingDate: model.packagingDate,
                expirationDate: model.expirationDate,
                ingrediant: model.ingrediant,
                isDeleted: model.isDeleted,
                unitPurchasePrice: model.unitPurchasePrice,
                status: model.status,
                image: model.image,
                threshold1: model.threshold1,
                threshold2: model.threshold2,
                price1: model.price1,
                price2: model.price2,
                flgConfig: model.flgConfig,
                traceability: model.traceability,
                traceabilityId: model.traceabilityId,
              );

              Navigate.to(context, EditResourceScreen(model: args));
              // Navigator.pushNamed(
              //   context,
              //   RoutesNames.editResourceScreen,
              //   arguments: args,
              // );
            },
            onTapDelete: () => deleteResourceDialogue(context),
          ),
        ],
      ),
    );
  }

  Text subTitleText(String text1, String text2) {
    return Text(
      '$text1 $text2',
      style: Styles.segoeUI(
        AppSize.text13.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Text salePriceText(String text) {
    return Text(
      "${AppStrings.salePriceText} : $text",
      style: Styles.segoeUI(
        AppSize.text13.sp,
        AppColors.blackColor,
      ),
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Styles.circularStdMedium(
        AppSize.text15.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Future<void> deleteResourceDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
          return DeleteItemDialogue2(
            text: model.resourceName,
            onDeleteButtonTap: () {
              if (model.isDeleted != true) {
                context.read<ResourceCubit>().deleteResource(model.resourceId);
                Navigator.of(context).pop();
                Navigate.toReplace(context, const ResorucesScreen());
                // Navigator.pushReplacementNamed(
                //     context, RoutesNames.resourcesScreen);
                SnackBarWidget.buildSnackBar(
                  context,
                  AppStrings.resourceDeleteSuccessText,
                  AppColors.greenColor,
                  Icons.check,
                  true,
                );
              } else {
                Navigator.of(context).pop();
                SnackBarWidget.buildSnackBar(
                  context,
                  AppStrings.notFoundText,
                  AppColors.redColor,
                  Icons.close,
                  true,
                );
              }
            },
          );
        });
  }
}
