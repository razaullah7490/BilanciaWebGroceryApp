// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Data/services/manager/command_service.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/command/bloc/command_cubit.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/command/command_screen.dart';
import 'package:intl/intl.dart';
import '../../../../../../Domain/models/manager/command_model.dart';
import '../../../../../common/delete_item_dialogue.dart';
import '../../../../../common/snack_bar_widget.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/routes/navigation.dart';

class CommandDetailContainer extends StatelessWidget {
  final CommandModel model;
  const CommandDetailContainer({
    Key? key,
    required this.model,
  }) : super(key: key);

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
        color: AppColors.searchTextFieldColor,
        border: Border.all(
          color: AppColors.primaryColor,
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
              titleText(model.commandType),
              CustomSizedBox.height(5),
              subTitleText(convertDateAndTime(model.issuingDateTime)),
              CustomSizedBox.height(10),
              statusContainer(),
            ],
          ),
          deleteButton(context),
        ],
      ),
    );
  }

  GestureDetector deleteButton(BuildContext context) {
    return GestureDetector(
      onTap: () => deleteCommandDialogue(context),
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

  Future<void> deleteCommandDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<CommandCubit, CommandState>(
            builder: (context, state) {
              return DeleteItemDialogue(
                text: model.commandType,
                onDeleteButtonTap: () async {
                  await context.read<CommandCubit>().deleteCommand(model.id);
                  Navigator.of(context).pop();
                  Navigate.toReplace(context, const CommandScreen());
                  SnackBarWidget.buildSnackBar(
                    context,
                    AppStrings.commandDeletedSuccessText,
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

  Widget statusContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.p15,
        vertical: AppSize.p6,
      ).r,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(
          AppBorderRadius.categoryStatusRadius,
        ).r,
      ),
      child: Center(
        child: Text(
          model.status,
          style: Styles.circularStdBook(
            AppSize.text12.sp,
            AppColors.whiteColor,
          ),
        ),
      ),
    );
  }

  Text subTitleText(String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Styles.segoeUI(
        AppSize.text13.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Styles.circularStdMedium(
        AppSize.text15.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  String convertDateAndTime(dt) {
    DateTime dateTime = DateTime.parse(dt);
    return DateFormat('MMM dd,yyy').add_jm().format(dateTime);
  }
}
