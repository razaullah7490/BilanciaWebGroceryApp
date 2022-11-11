import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final Widget suffixIcon;
  final ValueChanged onChanged;
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.suffixIcon,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: Styles.segoeUI(AppSize.text15.sp, AppColors.blackColor),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: AppStrings.searchHereText,
        hintStyle:
            Styles.circularStdBook(AppSize.text14.sp, AppColors.hintTextColor),
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.primaryColor,
          size: AppSize.icon28,
        ),
        suffixIcon: widget.suffixIcon,
        contentPadding: const EdgeInsets.only(
          top: AppSize.p16,
          bottom: AppSize.p16,
        ).r,
        filled: true,
        fillColor: AppColors.searchTextFieldColor,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppBorderRadius.searchTextFieldRadius.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppBorderRadius.searchTextFieldRadius.r),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppBorderRadius.searchTextFieldRadius.r),
          borderSide: const BorderSide(color: AppColors.secondaryColor),
        ),
      ),
    );
  }
}
