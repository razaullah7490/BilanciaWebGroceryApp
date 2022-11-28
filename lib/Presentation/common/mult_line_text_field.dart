import 'package:grocery/Application/exports.dart';

class MultiLineTextField extends StatelessWidget {
  final TextEditingController controller;
  const MultiLineTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v!.trim().isEmpty) {
          return null;
        } else if (v.trim().length < 40) {
          return AppStrings.descriptionValidateText;
        }
        return null;
      },
      controller: controller,
      keyboardType: TextInputType.multiline,
      style: Styles.segoeUI(AppSize.text15.sp, AppColors.blackColor),
      maxLines: 4,
      maxLength: 200,
      decoration: InputDecoration(
        hintText: AppStrings.enterDescriptionText,
        hintStyle:
            Styles.circularStdBook(AppSize.text13.sp, AppColors.hintTextColor),
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
    );
  }
}
