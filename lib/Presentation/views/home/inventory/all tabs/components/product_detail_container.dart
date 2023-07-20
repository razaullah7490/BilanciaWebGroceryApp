// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery/Application/exports.dart';

class ResourceData {
  int id;
  String name;
  bool isInventoryAction;

  ResourceData({
    required this.id,
    required this.name,
    required this.isInventoryAction,
  });
}

class ProductDetailContainer extends StatelessWidget {
  final ResourcesModel model;
  const ProductDetailContainer({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final args = ResourceData(
          id: model.resourceId,
          name: model.resourceName,
          isInventoryAction: false,
        );
        Navigate.to(context, AddResourceActionScreen(resourceData: args));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p16,
          vertical: AppSize.p12,
        ).r,
        margin: const EdgeInsets.symmetric(
          vertical: AppSize.m6,
          horizontal: AppSize.m10,
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
              child: Row(
                children: [
                  model.image.isEmpty
                      ? Container(
                          width: 80.w,
                          height: 77.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.secondaryColor,
                              width: 1.w,
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              Assets.noImage,
                              width: 45.w,
                              height: 45.h,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: model.image,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80.w,
                            height: 77.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppBorderRadius.dashboardSliderBorderRadius,
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              LoadingIndicator.loading(),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            size: AppSize.icon28.r,
                          ),
                        ),
                  CustomSizedBox.width(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleText(model.resourceName),
                        CustomSizedBox.height(6),
                        subTitleText(AppStrings.unitSalePriceText,
                            model.unitSalePrice.toString()),
                        CustomSizedBox.height(1),
                        subTitleText(AppStrings.quantityOnlyText,
                            model.stockQuantity.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            PopUpMenuWidget(
              onSelected: (value) {
                if (value == AppStrings.deleteText) {
                  deleteProductDialogue(context);
                }
                if (value == AppStrings.editText) {
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
                }
              },
            ),

            // editDeleteIcons(
            //   onTapEdit: () {
            //     // final args = ProductModel(
            //     //   productName: model.productName,
            //     //   productID: model.productID,
            //     //   productQuantity: model.productQuantity,
            //     //   imageUrl: model.imageUrl,
            //     // );

            //     Navigator.pushNamed(
            //       context,
            //       RoutesNames.editProductsScreen,
            //       //arguments: args,
            //     );
            //   },
            //   onTapDelete: () => deleteProductDialogue(context),
            // ),
          ],
        ),
      ),
    );
  }

  Text subTitleText(String text1, String text2) {
    return Text(
      '$text1 : $text2',
      style: Styles.segoeUI(
        AppSize.text12.sp,
        AppColors.containerTextColor,
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

  Future<void> deleteProductDialogue(BuildContext context) async {
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
              SnackBarWidget.buildSnackBar(
                context,
                AppStrings.productDeleteSuccessText,
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
      },
    );
  }
}
