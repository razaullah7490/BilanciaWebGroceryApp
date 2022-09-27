import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Domain/models/proceed_resource_model.dart';
import 'package:grocery/Presentation/common/delete_item_dialogue.dart';
import 'package:grocery/Presentation/common/edit_delete_container.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';

import '../../../../../common/snack_bar_widget.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/text_styles.dart';
import '../proceedResource/bloc/proceed_resource_cubit.dart';

class ProceedResourceDetailContainer extends StatelessWidget {
  final ProceedResourcesModel model;
  const ProceedResourceDetailContainer({
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedBox.height(5),
              titleText(model.resourceName),
              CustomSizedBox.height(5),
              subTitleText("${AppStrings.aliquotaIVAText} :",
                  model.aliquotaIva.toString()),
              subTitleText("${AppStrings.categoryText} :", model.category),
              subTitleText("${AppStrings.quantityOnlyText} :",
                  model.stockQuantity.toString()),
              CustomSizedBox.height(2),
              salePriceText(model.unitSalePrice.toString()),
              Row(
                children: [
                  subTitleText("${AppStrings.weightTypeText} :",
                      model.weightType.toString()),
                  CustomSizedBox.width(30),
                  subTitleText(
                      "${AppStrings.tareText} :", model.tare.toString()),
                ],
              ),
            ],
          ),
          editDeleteIcons(
            onTapEdit: () {
              final args = ProceedResourcesModel(
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
                status: model.status,
                tare: model.tare,
                weightType: model.weightType,
                ingrediant: model.ingrediant,
                expirationDate: model.expirationDate.toString(),
                packagingDate: model.packagingDate.toString(),
              );
              Navigator.pushNamed(
                  context, RoutesNames.editProceedResourceScreen,
                  arguments: args);
            },
            onTapDelete: () => deleteProceedResourceDialogue(context),
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
            text: AppStrings.resourceActionText,
            onDeleteButtonTap: () {
              context
                  .read<ProceedResourceCubit>()
                  .deleteProceedResource(model.resourceId);

              Navigator.of(context).pop();
              SnackBarWidget.buildSnackBar(
                context,
                AppStrings.proceedResourceDeleteSuccessText,
                AppColors.greenColor,
                Icons.check,
                true,
              );
            },
          );
        });
  }
}
