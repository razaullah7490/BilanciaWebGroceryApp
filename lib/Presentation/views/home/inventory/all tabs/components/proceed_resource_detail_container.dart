// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/delete_item_dialogue.dart';
import 'package:grocery/Presentation/common/edit_delete_container.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/navigation.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/proceedResource/addEditDeleteProceedResource/edit_proceed_resource.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/proceedResource/proceed_resource_screen.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/addEditDeleteProceedAction/add_proceed_resource_action.dart';
import '../../../../../../Domain/models/inventory/proceed_resource_model.dart';
import '../../../../../common/snack_bar_widget.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/text_styles.dart';
import '../proceedResource/bloc/proceed_resource_cubit.dart';

class ProceedResourceData {
  int id;
  String name;
  bool isInventoryAction;

  ProceedResourceData({
    required this.id,
    required this.name,
    required this.isInventoryAction,
  });
}

class ProceedResourceDetailContainer extends StatelessWidget {
  final ProceedResourcesModel model;
  const ProceedResourceDetailContainer({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final args = ProceedResourceData(
          id: model.id!,
          name: model.name!,
          isInventoryAction: false,
        );
        Navigate.to(context, AddProceedResourceActionScreen(model: args));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
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
                  titleText(model.name.toString()),
                  CustomSizedBox.height(5),
                  subTitleText("${AppStrings.aliquotaIVAText} :",
                      model.ivaAliquota.toString()),
                  subTitleText("${AppStrings.categoryText} :",
                      model.category.toString()),
                  subTitleText("${AppStrings.quantityOnlyText} :",
                      model.stockQuantity.toString()),
                  salePriceText(model.unitSalePrice.toString()),
                  subTitleText("${AppStrings.weightTypeText} :",
                      model.weightType.toString()),
                  CustomSizedBox.height(3),
                  model.isDeleted == true
                      ? Padding(
                          padding: const EdgeInsets.only(top: AppSize.p6).r,
                          child: Text(AppStrings.proceedResourceDeleteInText,
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
                final args = ProceedResourcesModel(
                  id: model.id,
                  name: model.name,
                  ivaAliquota: model.ivaAliquota,
                  ivaType: model.ivaType,
                  stockQuantity: model.stockQuantity,
                  stockQuantityThreshold: model.stockQuantityThreshold,
                  measureUnit: model.measureUnit,
                  barcode: model.barcode,
                  plu: model.plu,
                  shelfLife: model.shelfLife,
                  unitSalePrice: model.unitSalePrice,
                  revenuePercentage: model.revenuePercentage,
                  category: model.category,
                  isActive: model.isActive,
                  tare: model.tare,
                  weightType: model.weightType,
                  ingredient: model.ingredient,
                  expirationDate: model.expirationDate.toString(),
                  packagingDate: model.packagingDate.toString(),
                  threshold1: model.threshold1,
                  threshold2: model.threshold2,
                  price1: model.price1,
                  price2: model.price2,
                  isDeleted: model.isDeleted,
                  unitPurchasePrice: model.unitPurchasePrice,
                  traceability: model.traceability,
                  traceabilityId: model.traceabilityId,
                  assignedTo: model.assignedTo,
                  flgConfig: model.flgConfig,
                  image: model.image,
                  business: model.business,
                  madeWith: model.madeWith,
                );
                Navigate.to(context, EditProceedResourceScreen(model: args));
              },
              onTapDelete: () => deleteProceedResourceDialogue(context),
            ),
          ],
        ),
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

  Future<void> deleteProceedResourceDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
          return DeleteItemDialogue(
            text: model.name.toString(),
            onDeleteButtonTap: () async {
              if (model.isDeleted != true) {
                context
                    .read<ProceedResourceCubit>()
                    .deleteProceedResource(model.id);

                Navigator.of(context).pop();
                Navigate.toReplace(context, const ProceedResourceScreen());
                // Navigator.pushReplacementNamed(
                //     context, RoutesNames.proceedResourceScreen);
                SnackBarWidget.buildSnackBar(
                  context,
                  AppStrings.proceedResourceDeleteSuccessText,
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
