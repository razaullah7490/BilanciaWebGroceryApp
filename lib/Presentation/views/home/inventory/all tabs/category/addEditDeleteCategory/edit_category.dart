// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Domain/models/category_model.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_drop_down.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/common/snack_bar_widget.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/bloc/category_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/category_view_model.dart';

class EditCategoryScreen extends StatefulWidget {
  final CategoryModel model;
  const EditCategoryScreen({
    super.key,
    required this.model,
  });

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  final aliquotaIvaContoller = TextEditingController();
  final defaultPriceController = TextEditingController();
  final minValueContoller = TextEditingController();
  final maxValueController = TextEditingController();
  var ivaType;
  var status;

  @override
  void initState() {
    categoryNameController.text = widget.model.categoryName;
    aliquotaIvaContoller.text = widget.model.aliquotaIva.toString();
    defaultPriceController.text = widget.model.defaultPrice.toString();
    minValueContoller.text = widget.model.minPrice.toString();
    maxValueController.text = widget.model.maxPrice.toString();
    ivaType = widget.model.ivaType;
    status = widget.model.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.editCategoryText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p18).r,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              textFields(),
              CustomSizedBox.height(40),
              BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                return CustomButton(
                  text: AppStrings.updateText,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      context.read<CategoryCubit>().editCategory(
                            widget.model.categoryId,
                            CategoryModel(
                              categoryId: widget.model.categoryId,
                              categoryName: categoryNameController.text,
                              defaultPrice:
                                  int.parse(defaultPriceController.text),
                              minPrice:
                                  int.parse(minValueContoller.text.toString()),
                              maxPrice:
                                  int.parse(maxValueController.text.toString()),
                              ivaType: ivaType.toString(),
                              status: status.toString(),
                              aliquotaIva: int.parse(
                                  aliquotaIvaContoller.text.toString()),
                            ),
                          );
                      Navigator.of(context).pop();
                      SnackBarWidget.buildSnackBar(
                        context,
                        AppStrings.categoryUpdatedSuccessText,
                        AppColors.greenColor,
                        Icons.check,
                        true,
                      );
                    }
                  },
                );
              }),
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
          CustomSizedBox.height(30),
          CustomTextField(
            controller: categoryNameController,
            labelText: AppStrings.categoryNameText,
            hintText: AppStrings.enterCategoryNameText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideDefaultPriceText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: defaultPriceController,
            labelText: AppStrings.defaultPriceText,
            hintText: AppStrings.enterDefaultPriceText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideAliquotaIvaText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: minValueContoller,
            labelText: AppStrings.minValueText,
            hintText: AppStrings.enterMinValueText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideMinValueText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: maxValueController,
            labelText: AppStrings.maxValueText,
            hintText: AppStrings.enterMaxValueText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
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
          CustomTextField(
            controller: aliquotaIvaContoller,
            labelText: AppStrings.aliquotaIVAText,
            hintText: AppStrings.enterAliquotaIvaText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
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
