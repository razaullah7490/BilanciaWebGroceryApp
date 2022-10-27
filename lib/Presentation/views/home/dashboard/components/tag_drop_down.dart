// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';

class TagDropDown extends StatelessWidget {
  final String hintText;
  dynamic value;

  final ValueChanged onChanged;
  final List<DropdownMenuItem<Object>> itemsMap;
  TagDropDown({
    super.key,
    required this.hintText,
    required this.value,
    required this.onChanged,
    required this.itemsMap,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => null,
      decoration: InputDecoration(
        errorMaxLines: 1,
        contentPadding:
            const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12).r,
        errorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppBorderRadius.dropDownBorderRadius).r,
            borderSide: BorderSide(
              color: AppColors.redColor2,
              width: 1.w,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppBorderRadius.dropDownBorderRadius).r,
            borderSide: BorderSide(
              color: AppColors.secondaryColor,
              width: 1.w,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppBorderRadius.dropDownBorderRadius).r,
            borderSide: BorderSide(
              color: AppColors.secondaryColor,
              width: 1.w,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppBorderRadius.dropDownBorderRadius).r,
            borderSide: BorderSide(
              color: AppColors.secondaryColor,
              width: 1.w,
            )),
      ),
      hint: Text(
        hintText,
        style: Styles.circularStdBook(
          AppSize.text14.sp,
          AppColors.hintTextColor,
        ),
      ),
      dropdownColor: Colors.white,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.secondaryColor,
      ),
      iconSize: AppSize.icon28.r,
      isExpanded: true,
      style: Styles.circularStdMedium(
        AppSize.text14.sp,
        AppColors.primaryColor,
      ),
      value: value,
      onChanged: onChanged,
      items: itemsMap,
    );
  }
}
