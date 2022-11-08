import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import '../../../../../resources/border_radius.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/text_styles.dart';

class IngredientMultiLineTextField extends StatelessWidget {
  final TextEditingController controller;
  final Color color;
  final int maxline;
  final double fontSize;
  const IngredientMultiLineTextField({
    super.key,
    required this.controller,
    required this.color,
    required this.maxline,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v!.trim().isEmpty) {
          return AppStrings.provideIngredientText;
        } else if (v.trim().length > 1200) {
          return AppStrings.ingredientDescriptionGreaterText;
        }
        return null;
      },
      controller: controller,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      style: Styles.segoeUI(fontSize, AppColors.blackColor),
      maxLines: maxline,
      maxLength: 1200,
      decoration: InputDecoration(
        counterText: "",
        hintText: AppStrings.enterDescriptionText,
        hintStyle:
            Styles.circularStdBook(AppSize.text13.sp, AppColors.hintTextColor),
        filled: true,
        fillColor: AppColors.textFieldFillColor,
        contentPadding: const EdgeInsets.only(
          right: AppSize.p15,
          left: AppSize.p15,
          top: AppSize.p16,
          bottom: AppSize.p16,
        ).r,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
          borderSide: BorderSide(color: color),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
          borderSide: BorderSide(color: color),
        ),
      ),
    );
  }
}
