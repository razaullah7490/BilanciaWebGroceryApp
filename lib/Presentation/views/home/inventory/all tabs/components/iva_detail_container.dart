// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Data/services/manager/iva_service.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/iva/ivaBloc/manager_iva_cubit.dart';
import '../../../../../../Data/errors/custom_error.dart';
import '../../../../../../Domain/models/manager/iva_model.dart';
import '../../../../../common/delete_item_dialogue.dart';
import '../../../../../common/edit_delete_container.dart';
import '../../../../../common/loading_indicator.dart';
import '../../../../../common/snack_bar_widget.dart';
import '../../../../../resources/border_radius.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/routes/navigation.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/text_styles.dart';
import '../iva/iva.dart';

class IVADetailContainer extends StatefulWidget {
  final IvaModel model;
  const IVADetailContainer({
    super.key,
    required this.model,
  });

  @override
  State<IVADetailContainer> createState() => _IVADetailContainerState();
}

class _IVADetailContainerState extends State<IVADetailContainer> {
  bool isEditPressed = false;
  final formKey = GlobalKey<FormState>();
  final ivaValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.p18,
        vertical: AppSize.p15,
      ).r,
      margin: const EdgeInsets.symmetric(
        vertical: AppSize.m6,
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
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      valueText(),
                      isEditPressed == false
                          ? Text(
                              widget.model.value.toString(),
                              style: Styles.segoeUI(
                                AppSize.text14.sp,
                                AppColors.containerTextColor,
                              ),
                            )
                          : Flexible(
                              child: IvaTextField(
                                controller: ivaValueController,
                              ),
                            ),
                    ],
                  ),
                ),
                isEditPressed == false
                    ? editDeleteIcons(
                        onTapDelete: () => deleteIvaDialogue(context),
                        onTapEdit: () {
                          setState(() {
                            ivaValueController.text =
                                widget.model.value.toString();
                            isEditPressed = !isEditPressed;
                          });
                        },
                      )
                    : ivaEditButton(
                        onTap: () async {
                          var res = await IvaService.editIva(
                            widget.model.id,
                            ivaValueController.text.isEmpty
                                ? "0.0"
                                : ivaValueController.text,
                          );

                          if (res == true) {
                            await SnackBarWidget.buildSnackBar(
                              context,
                              AppStrings.ivaUpdatedSuccessText,
                              AppColors.greenColor,
                              Icons.check,
                              true,
                            );

                            await context.read<ManagerIvaCubit>().getIva();
                          }
                        },
                      ),
              ],
            ),
            if (widget.model.isDeleted == true)
              Text(
                AppStrings.ivaDeleteInText,
                style: Styles.segoeUI(
                  AppSize.text12.sp,
                  AppColors.redColor2,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget ivaEditButton({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Icon(
            Icons.check_circle_rounded,
            color: AppColors.primaryColor,
            size: AppSize.icon25.r,
          ),
          CustomSizedBox.width(2),
          Text(
            AppStrings.updateText,
            style: Styles.segoeUI(
              AppSize.text14.sp,
              AppColors.primaryColor,
            ),
          )
        ],
      ),
    );
  }

  Text valueText() {
    return Text(
      "${AppStrings.valueText}: ",
      style: Styles.circularStdMedium(
        AppSize.text17.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Future<void> deleteIvaDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<ManagerIvaCubit, ManagerIvaState>(
            builder: (context, state) {
              return DeleteItemDialogue(
                text: widget.model.value.toString(),
                onDeleteButtonTap: () async {
                  var res = await context
                      .read<ManagerIvaCubit>()
                      .deleteIva(widget.model.id);

                  if (res == true) {
                    Navigator.of(context).pop();
                    Navigate.toReplace(context, const IvaScreen());
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.ivaDeleteSuccessText,
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
        });
  }
}

class IvaTextField extends StatelessWidget {
  final TextEditingController controller;
  const IvaTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 35.h,
      child: TextFormField(
        controller: controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        style: Styles.segoeUI(AppSize.text15.sp, AppColors.blackColor),
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: AppSize.p15).r,
          hintText: AppStrings.valueText,
          hintStyle: Styles.circularStdBook(
              AppSize.text13.sp, AppColors.hintTextColor),
          filled: true,
          fillColor: AppColors.textFieldFillColor,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
            borderSide: const BorderSide(color: AppColors.secondaryColor),
          ),
        ),
      ),
    );
  }
}
