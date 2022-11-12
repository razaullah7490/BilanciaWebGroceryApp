// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/routes/navigation.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/processed_resource_action.dart';
import '../../../../../../Domain/models/inventory/proceed_resource_action_model.dart';
import '../../../../../common/delete_item_dialogue.dart';
import '../../../../../common/snack_bar_widget.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/border_radius.dart';
import '../../../../../resources/colors_palette.dart';
import '../processedResourceAction/bloc/proceed_resource_action_cubit.dart';

class ProceedResourceActionDetailContainer extends StatelessWidget {
  final int resourceActionId;
  final String resourceActionName;
  final double quantity;
  final double money;
  final String moneyType;
  final int priceCounter;
  final int resource;
  final bool isForInternalUsage;
  final String dateTime;
  const ProceedResourceActionDetailContainer({
    super.key,
    required this.resourceActionId,
    required this.resourceActionName,
    required this.quantity,
    required this.money,
    required this.moneyType,
    required this.priceCounter,
    required this.resource,
    required this.isForInternalUsage,
    required this.dateTime,
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
              titleText(resourceActionName.toString()),
              CustomSizedBox.height(5),
              subTitleText(
                  "${AppStrings.quantityOnlyText} :", quantity.toString()),
              moneyAndResourceText(
                  AppStrings.moneyText, "\$${money.toString()}"),
              subTitleText(
                  "${AppStrings.priceCounterText} :", priceCounter.toString()),
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
                text: resourceActionName,
                onDeleteButtonTap: () async {
                  await context
                      .read<ProceedResourceActionCubit>()
                      .deletProceedResourceAction(resourceActionId);

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
