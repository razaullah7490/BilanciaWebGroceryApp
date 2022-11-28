import 'package:grocery/Application/exports.dart';

class MultiSelectDropDown extends StatelessWidget {
  final List<MultiSelectItem<int>> itemsMap;
  final ValueChanged onConfirm;
  final Text buttonText;
  final List<int> initial;
  const MultiSelectDropDown({
    super.key,
    required this.itemsMap,
    required this.onConfirm,
    required this.buttonText,
    required this.initial,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: AppSize.p8,
        right: AppSize.p8,
        top: AppSize.p3,
        bottom: AppSize.p3,
      ).r,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(AppBorderRadius.multiDropDownRadius).r,
        border: Border.all(
          color: AppColors.secondaryColor,
          width: 1.w,
        ),
      ),
      child: MultiSelectDialogField<int>(
        initialValue: initial,
        dialogWidth: MediaQueryValues(context).width * 1,
        dialogHeight: MediaQuery.of(context).size.width * 1,
        separateSelectedItems: true,
        checkColor: AppColors.whiteColor,
        selectedColor: AppColors.primaryColor,
        itemsTextStyle: Styles.circularStdBook(
          AppSize.text14.sp,
          AppColors.blackColor,
        ),
        selectedItemsTextStyle: Styles.circularStdMedium(
          AppSize.text14.sp,
          AppColors.primaryColor,
        ),
        buttonIcon: Icon(
          Icons.expand_more_rounded,
          color: AppColors.secondaryColor,
          size: AppSize.icon28.r,
        ),
        confirmText: Text(
          AppStrings.addText,
          style: Styles.segoeUI(AppSize.text15.sp, AppColors.primaryColor),
        ),
        cancelText: Text(
          AppStrings.cancelText,
          style: Styles.segoeUI(AppSize.text15.sp, AppColors.redColor2),
        ),
        items: itemsMap,
        searchable: true,
        title: Text(
          AppStrings.searchParticipantsText,
          style:
              Styles.circularStdBook(AppSize.text18.sp, AppColors.blackColor),
        ),
        searchHint: AppStrings.searchParticipantsHereText,
        searchHintStyle: Styles.segoeUI(
          AppSize.text15.sp,
          AppColors.blackColor,
        ),
        searchIcon: Icon(
          Icons.search_rounded,
          size: AppSize.searchIcon.r,
        ),
        buttonText: buttonText,
        onConfirm: onConfirm,
        chipDisplay: MultiSelectChipDisplay.none(),
        decoration: const BoxDecoration(),
      ),
    );
  }
}
