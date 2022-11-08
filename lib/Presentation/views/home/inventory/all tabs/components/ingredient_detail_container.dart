// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Data/services/manager/ingredients_service.dart';
import 'package:grocery/Domain/models/manager/ingredient_model.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/ingredient_textfield.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/ingredients/ingredientsBloc/ingredients_cubit.dart';
import '../../../../../common/delete_item_dialogue.dart';
import '../../../../../common/edit_delete_container.dart';
import '../../../../../common/snack_bar_widget.dart';
import '../../../../../resources/border_radius.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/routes/navigation.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/text_styles.dart';
import '../ingredients/ingredients.dart';

class IngredientDetailContainer extends StatefulWidget {
  final IngredientModel model;
  const IngredientDetailContainer({
    super.key,
    required this.model,
  });

  @override
  State<IngredientDetailContainer> createState() =>
      _IngredientDetailContainerState();
}

class _IngredientDetailContainerState extends State<IngredientDetailContainer> {
  bool isEditPressed = false;
  final formKey = GlobalKey<FormState>();
  final ingredientDescriptionController = TextEditingController();
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
                isEditPressed == false
                    ? Flexible(
                        child: Text(
                          widget.model.description.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.segoeUI(
                            AppSize.text14.sp,
                            AppColors.containerTextColor,
                          ),
                        ),
                      )
                    : Flexible(
                        child: Padding(
                        padding: const EdgeInsets.only(right: AppSize.p8).r,
                        child: IngredientMultiLineTextField(
                          controller: ingredientDescriptionController,
                          maxline: 2,
                          color: AppColors.secondaryColor,
                          fontSize: AppSize.text13.sp,
                        ),
                      )),
                isEditPressed == false
                    ? editDeleteIcons(
                        onTapDelete: () => deleteIngredientDialogue(context),
                        onTapEdit: () {
                          setState(() {
                            ingredientDescriptionController.text =
                                widget.model.description.toString();
                            isEditPressed = !isEditPressed;
                          });
                        },
                      )
                    : descriptionEditButton(
                        onTap: () async {
                          var res = await IngredientService.editIngredient(
                            widget.model.ingrediantId,
                            ingredientDescriptionController.text,
                          );

                          if (res == true) {
                            log('1');
                            await SnackBarWidget.buildSnackBar(
                              context,
                              AppStrings.ingredientUpdatedSuccessText,
                              AppColors.greenColor,
                              Icons.check,
                              true,
                            );
                            await context
                                .read<IngredientsCubit>()
                                .getIngredients();
                          }

                          if (res == false) {
                            log('2');
                            await SnackBarWidget.buildSnackBar(
                              context,
                              AppStrings.thisFieldCannotBeOmittedText,
                              AppColors.redColor,
                              Icons.close,
                              true,
                            );
                          }
                        },
                      ),
              ],
            ),
            if (widget.model.isDeleted == true)
              Padding(
                padding: const EdgeInsets.only(top: AppSize.p4).r,
                child: Text(
                  AppStrings.ingredientDeleteInText,
                  style: Styles.segoeUI(
                    AppSize.text12.sp,
                    AppColors.redColor2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget descriptionText() {
    return Flexible(
      child: Text(
        "${AppStrings.descriptionText}: ",
        style: Styles.circularStdMedium(
          AppSize.text17.sp,
          AppColors.containerTextColor,
        ),
      ),
    );
  }

  Widget descriptionEditButton({required VoidCallback onTap}) {
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

  Future<void> deleteIngredientDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<IngredientsCubit, IngredientsState>(
            builder: (context, state) {
              return DeleteItemDialogue(
                text: widget.model.description,
                onDeleteButtonTap: () async {
                  var res = await context
                      .read<IngredientsCubit>()
                      .deleteIngredient(widget.model.ingrediantId);

                  if (res == true) {
                    Navigator.of(context).pop();
                    Navigate.toReplace(context, const IngredientScreen());
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.ingredientDeleteSuccessText,
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
