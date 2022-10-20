// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/edit_delete_container.dart';
import 'package:grocery/Presentation/resources/routes/navigation.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/addEditDeleteProceedAction/add_proceed_resource_action.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/processed_resource_action.dart';
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
          deleteButton(context),
        ],
      ),
    );
  }

  GestureDetector deleteButton(BuildContext context) {
    return GestureDetector(
      onTap: () => deleteProceedResourceActionDialogue(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSize.p8, vertical: 7).r,
        decoration: BoxDecoration(
          color: AppColors.editDeleteFillColor,
          border: Border.all(
            color: AppColors.editDeleteBorderColor,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.delete,
          color: Colors.red.shade400,
          size: AppSize.editDeleteIconSize.r,
        ),
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
          return BlocBuilder<ProceedResourceActionCubit,
              ProceedResourceActionState>(
            builder: (context, state) {
              return DeleteItemDialogue(
                text: AppStrings.processedResourceActionText,
                onDeleteButtonTap: () async {
                  await context
                      .read<ProceedResourceActionCubit>()
                      .deletProceedResourceAction(
                          model.processedresourceActionId);

                  Navigator.of(context).pop();
                  Navigate.toReplace(
                      context, const ProcessedResourceActionScreen());
                  // Navigator.pushReplacementNamed(
                  //     context, RoutesNames.proceedResourceActionsScreen);
                  SnackBarWidget.buildSnackBar(
                    context,
                    AppStrings.proceedResourceActionDeleteSuccessText,
                    AppColors.greenColor,
                    Icons.check,
                    true,
                  );
                },
              );
            },
          );
        });
  }
}
