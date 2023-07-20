// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously
import 'package:grocery/Application/exports.dart';

class CategoryData {
  final int id;
  final String name;
  CategoryData({
    required this.id,
    required this.name,
  });
}

class CategoryDetailContainer extends StatelessWidget {
  final CategoryModel model;
  const CategoryDetailContainer({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final args = CategoryData(
          id: model.categoryId,
          name: model.categoryName,
        );
        Navigate.to(context, ProductsAssociatedToCategory(categoryData: args));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSizedBox.height(5),
                  titleText(model.categoryName),
                  CustomSizedBox.height(5),
                  subTitleText("${AppStrings.aliquotaIVAText}: ",
                      model.aliquotaIva.toString()),
                  subTitleText("${AppStrings.ivaTypeText}: ", model.ivaType),
                  CustomSizedBox.height(10),
                  statusContainer(),
                  model.isDeleted == true
                      ? Padding(
                          padding: const EdgeInsets.only(top: AppSize.p6).r,
                          child: Text(AppStrings.categoryDeleteInText,
                              style: Styles.segoeUI(
                                AppSize.text10.sp,
                                AppColors.redColor2,
                              )),
                        )
                      : Container()
                ],
              ),
            ),
            editDeleteIcons(
              onTapEdit: () {
                final args = CategoryModel(
                  categoryId: model.categoryId,
                  categoryName: model.categoryName,
                  defaultPrice: model.defaultPrice,
                  minPrice: model.minPrice,
                  maxPrice: model.maxPrice,
                  ivaType: model.ivaType,
                  status: model.status,
                  aliquotaIva: model.aliquotaIva,
                  discountPrice: model.discountPrice,
                  isDeleted: model.isDeleted,
                  keyModifier: model.keyModifier,
                  idGruppo: model.idGruppo,
                  idAuxLan: model.idAuxLan,
                  tipoSconto: model.tipoSconto,
                  battSingola: model.battSingola,
                );
                Navigate.to(context, EditCategoryScreen(model: args));
              },
              onTapDelete: () => deleteCategoryDialogue(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget statusContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.p15,
        vertical: AppSize.p6,
      ).r,
      decoration: BoxDecoration(
        color: model.status == true
            ? AppColors.primaryColor
            : Colors.yellow.shade600,
        borderRadius: BorderRadius.circular(
          AppBorderRadius.categoryStatusRadius,
        ).r,
      ),
      child: Text(
        model.status == true ? "Attivo" : "Inattivo",
        style: Styles.segoeUI(
          AppSize.text12.sp,
          AppColors.whiteColor,
        ),
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

  Widget titleText(String text) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Styles.circularStdMedium(
        AppSize.text15.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Future<void> deleteCategoryDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
          return DeleteItemDialogue2(
            text: model.categoryName,
            onDeleteButtonTap: () async {
              if (model.isDeleted != true) {
                await context
                    .read<CategoryCubit>()
                    .deleteCategory(model.categoryId);
                Navigator.of(context).pop();
                Navigate.toReplace(context, const CategoryScreen());

                SnackBarWidget.buildSnackBar(
                  context,
                  AppStrings.categoryDeleteSuccessText,
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
        });
  }
}
