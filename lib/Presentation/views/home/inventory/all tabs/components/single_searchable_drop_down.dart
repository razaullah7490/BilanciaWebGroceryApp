// ignore_for_file: must_be_immutable
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_choices/search_choices.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/border_radius.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/text_styles.dart';

class SingleSearchableDialogue extends StatelessWidget {
  final String hintText;
  dynamic value;
  final ValueChanged onChanged;
  final List<DropdownMenuItem<Object>> itemsMap;
  SingleSearchableDialogue({
    super.key,
    required this.hintText,
    required this.value,
    required this.onChanged,
    required this.itemsMap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.p10).r,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(AppBorderRadius.multiDropDownRadius).r,
        border: Border.all(
          color: AppColors.secondaryColor,
          width: 1.w,
        ),
      ),
      child: SearchChoices.single(
        clearSearchIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.p10).r,
          child: const Icon(
            Icons.close,
            color: AppColors.hintTextColor,
            size: AppSize.editDeleteIconSize,
          ),
        ),
        icon: Icon(
          Icons.expand_more_rounded,
          color: AppColors.secondaryColor,
          size: AppSize.icon28.r,
        ),
        displayClearIcon: false,
        searchInputDecoration: InputDecoration(
          hintText: AppStrings.searchResourceText,
          hintStyle: Styles.circularStdBook(
              AppSize.text13.sp, AppColors.hintTextColor),
          filled: true,
          fillColor: AppColors.textFieldFillColor,
          contentPadding: const EdgeInsets.only(
                  left: AppSize.p18, top: AppSize.p16, bottom: AppSize.p16)
              .r,
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
        closeButton: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSize.p4,
              horizontal: AppSize.p8,
            ).r,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                AppStrings.closeText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    Styles.segoeUI(AppSize.text18.sp, AppColors.primaryColor),
              ),
            ),
          ),
        ),
        underline: const SizedBox(),
        padding: EdgeInsets.zero,
        style: Styles.segoeUI(AppSize.text14.sp, AppColors.blackColor),
        items: itemsMap,
        value: value,
        onChanged: onChanged,
        isExpanded: true,
        hint: Text(
          hintText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.segoeUI(AppSize.text14.sp, AppColors.blackColor),
        ),
        searchHint: Text(
          AppStrings.searchResourceText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.segoeUI(AppSize.text18.sp, AppColors.primaryColor),
        ),
      ),
    );
  }
}
