// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Domain/models/category_model.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_drop_down.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/common/loading_indicator.dart';
import 'package:grocery/Presentation/common/snack_bar_widget.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/bloc/category_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/category_view_model.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  final aliquotaIvaContoller = TextEditingController();
  final defaultPriceController = TextEditingController();
  final minValueContoller = TextEditingController();
  final maxValueController = TextEditingController();
  var ivaType;
  var status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.addCategoryText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              textFields(),
              CustomSizedBox.height(50),
              BlocBuilder<CategoryCubit, CategoryState>(
                  builder: ((context, state) {
                if (state.status == CategoryEnum.loading) {
                  return LoadingIndicator.loading();
                }

                return CustomButton(
                  text: AppStrings.addCategoryText,
                  onTap: () async {
                    Random random = Random();
                    int randomNumber = random.nextInt(100);
                    if (formKey.currentState!.validate()) {
                      context.read<CategoryCubit>().addCategory(CategoryModel(
                            categoryId: randomNumber,
                            categoryName: categoryNameController.text,
                            defaultPrice: int.parse(
                                defaultPriceController.text.toString()),
                            minPrice:
                                int.parse(minValueContoller.text.toString()),
                            maxPrice:
                                int.parse(maxValueController.text.toString()),
                            ivaType: ivaType.toString(),
                            status: status.toString(),
                            aliquotaIva:
                                int.parse(aliquotaIvaContoller.text.toString()),
                          ));
                      Navigator.of(context).pop();
                      SnackBarWidget.buildSnackBar(
                        context,
                        AppStrings.categoryAddedSuccessText,
                        AppColors.greenColor,
                        Icons.check,
                        true,
                      );
                    }
                  },
                );
              })),
              CustomSizedBox.height(10),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFields() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox.height(40),
          textFieldUpperText(AppStrings.categoryNameText),
          CustomTextField(
            controller: categoryNameController,
            labelText: AppStrings.categoryNameText,
            hintText: AppStrings.enterCategoryNameText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideDefaultPriceText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.defaultPriceText),
          CustomTextField(
            controller: defaultPriceController,
            labelText: AppStrings.defaultPriceText,
            hintText: AppStrings.enterDefaultPriceText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideAliquotaIvaText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.minValueText),
          CustomTextField(
            controller: minValueContoller,
            labelText: AppStrings.minValueText,
            hintText: AppStrings.enterMinValueText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideMinValueText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.maxValueText),
          CustomTextField(
            controller: maxValueController,
            labelText: AppStrings.maxValueText,
            hintText: AppStrings.enterMaxValueText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.maxValueText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.selectIvaTypeText),
          CustomDropDownWidget(
            hintText: AppStrings.ivaTypeText,
            value: ivaType,
            itemsList: CategoryViewModel.ivaTypeList,
            validationText: AppStrings.provideIVAtypeText,
            onChanged: (v) {
              setState(() {
                ivaType = v;
              });
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.selectStatusText),
          CustomDropDownWidget(
            hintText: AppStrings.statusText,
            value: status,
            itemsList: CategoryViewModel.statusList,
            validationText: AppStrings.provideStatusText,
            onChanged: (v) {
              setState(() {
                status = v;
              });
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.aliquotaIVAText),
          CustomTextField(
            controller: aliquotaIvaContoller,
            labelText: AppStrings.aliquotaIVAText,
            hintText: AppStrings.enterAliquotaIvaText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideAliquotaIvaText;
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget textFieldUpperText(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.p2,
      ).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style:
                Styles.circularStdBook(AppSize.text15.sp, AppColors.blackColor),
          ),
          CustomSizedBox.height(10),
        ],
      ),
    );
  }
}
