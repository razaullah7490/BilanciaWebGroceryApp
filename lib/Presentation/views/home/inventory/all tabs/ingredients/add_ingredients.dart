// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/loading_indicator.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/ingredient_textfield.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/ingredients/ingredientsBloc/ingredients_cubit.dart';
import '../../../../../common/snack_bar_widget.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/sized_box.dart';
import '../../../../../resources/text_styles.dart';

class AddIngredientBottomSheet extends StatefulWidget {
  const AddIngredientBottomSheet({super.key});

  @override
  State<AddIngredientBottomSheet> createState() =>
      _AddIngredientBottomSheetState();
}

class _AddIngredientBottomSheetState extends State<AddIngredientBottomSheet> {
  final ingredientDescriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSizedBox.height(25),
            titleText(),
            CustomSizedBox.height(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.p18).r,
              child: IngredientMultiLineTextField(
                controller: ingredientDescriptionController,
                color: AppColors.primaryColor,
                maxline: 4,
                fontSize: AppSize.text15.sp,
              ),
            ),
            CustomSizedBox.height(20),
            BlocListener<IngredientsCubit, IngredientsState>(
              listener: (context, state) {
                if (state.status == IngredientsEnum.success) {
                  Navigator.of(context).pop();
                  SnackBarWidget.buildSnackBar(
                    context,
                    AppStrings.ingredientAddedSuccessText,
                    AppColors.greenColor,
                    Icons.check,
                    true,
                  );

                  context.read<IngredientsCubit>().getIngredients();
                }
                if (state.status == IngredientsEnum.error) {
                  SnackBarWidget.buildSnackBar(
                    context,
                    state.error.error,
                    AppColors.redColor,
                    Icons.close,
                    true,
                  );
                }
              },
              child: BlocBuilder<IngredientsCubit, IngredientsState>(
                builder: (context, state) {
                  if (state.status == IngredientsEnum.loading) {
                    return LoadingIndicator.loading();
                  }
                  return CustomButton(
                    scale: 0.8,
                    text: AppStrings.addText,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        context.read<IngredientsCubit>().addIngredient(
                              ingredientDescriptionController.text,
                            );
                      }
                    },
                  );
                },
              ),
            ),
            CustomSizedBox.height(20),
          ],
        ),
      ),
    );
  }

  Widget titleText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.addIngredientText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.circularStdMedium(
            AppSize.text17.sp,
            AppColors.containerTextColor,
          ),
        ),
        CustomSizedBox.width(4),
        const Icon(
          Icons.add_circle_outline_rounded,
          color: AppColors.primaryColor,
          size: AppSize.icon25,
        ),
      ],
    );
  }
}
