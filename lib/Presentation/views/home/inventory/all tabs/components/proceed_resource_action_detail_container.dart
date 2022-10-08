import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/edit_delete_container.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';

import '../../../../../../Domain/models/inventory/proceed_resource_action_model.dart';
import '../../../../../common/delete_item_dialogue.dart';
import '../../../../../common/snack_bar_widget.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/border_radius.dart';
import '../../../../../resources/colors_palette.dart';
import '../processedResourceAction/bloc/proceed_resource_action_cubit.dart';

class ProceedResourceActionDetailContainer extends StatelessWidget {
  final ProcessedResourceActionModel model;
  const ProceedResourceActionDetailContainer({
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
              titleText(model.processedresourceActionName),
              CustomSizedBox.height(5),
              subTitleText("${AppStrings.quantityOnlyText} :",
                  model.quantity.toString()),
              moneyAndResourceText(
                  AppStrings.moneyText, "\$${model.money.toString()}"),
              subTitleText("${AppStrings.priceCounterText} :",
                  model.priceCounter.toString()),
              moneyAndResourceText(
                  AppStrings.resourceText, model.resource.toString()),
            ],
          ),
          editDeleteIcons(
            onTapEdit: () {
              // final args = ProcessedResourceActionModel(
              //   processedresourceActionId: model.processedresourceActionId,
              //   processedresourceActionName: model.processedresourceActionName,
              //   quantity: model.quantity,
              //   money: model.money,
              //   priceCounter: model.priceCounter,
              //   resource: model.resource,
              //   isForInternalUsage: model.isForInternalUsage,
              // );
              Navigator.pushNamed(
                context,
                RoutesNames.editProceedResourceActionsScreen,
                //arguments: args,
              );
            },
            onTapDelete: () => deleteProceedResourceActionDialogue(context),
          ),
        ],
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

  Text subTitleText(String text1, String text2) {
    return Text(
      '$text1 $text2',
      style: Styles.segoeUI(
        AppSize.text13.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Text moneyAndResourceText(String text1, String text2) {
    return Text(
      "$text1 : $text2",
      style: Styles.segoeUI(
        AppSize.text13.sp,
        AppColors.blackColor,
      ),
    );
  }

  Future<void> deleteProceedResourceActionDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
          return DeleteItemDialogue(
            text: AppStrings.processedResourceActionText,
            onDeleteButtonTap: () {
              context
                  .read<ProceedResourceActionCubit>()
                  .deletProceedResourceAction(model.processedresourceActionId);
              Navigator.of(context).pop();
              SnackBarWidget.buildSnackBar(
                context,
                AppStrings.proceedResourceActionDeleteSuccessText,
                AppColors.greenColor,
                Icons.check,
                true,
              );
            },
          );
        });
  }
}
