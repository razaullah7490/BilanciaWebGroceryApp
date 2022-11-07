import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import '../../../../../../Domain/models/manager/iva_model.dart';
import '../../../../../common/edit_delete_container.dart';
import '../../../../../resources/border_radius.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/text_styles.dart';

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
                        onTapDelete: () {},
                        onTapEdit: () {
                          setState(() {
                            log("Value ${widget.model.value}");
                            ivaValueController.text =
                                widget.model.value.toString();
                            isEditPressed = !isEditPressed;
                          });
                        },
                      )
                    : Row(
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
              ],
            ),
          ],
        ),
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
