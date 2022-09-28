// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

import '../../../../../../../Data/errors/custom_error.dart';
import '../../../../../../../Domain/models/inventory/category_model.dart';
import '../../../../../../common/loading_indicator.dart';
import '../../../../../../resources/routes/routes_names.dart';
import '../../../../../../state management/bloc/ivaBloc/manager_iva_cubit.dart';

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
  final discountPriceContoller = TextEditingController();
  final defaultPriceController = TextEditingController();
  final minValueContoller = TextEditingController();
  final maxValueController = TextEditingController();
  var ivaType;
  var status;
  var aliquotaIva;

  @override
  void initState() {
    categoryNameController.text = widget.model.categoryName;
    discountPriceContoller.text = widget.model.discountPrice.toString();
    defaultPriceController.text = widget.model.defaultPrice.toString();
    minValueContoller.text = widget.model.minPrice.toString();
    maxValueController.text = widget.model.maxPrice.toString();
    ivaType = widget.model.ivaType.toString();
    status = widget.model.status == true ? "Active" : "InActive";
    aliquotaIva = widget.model.aliquotaIva;
    context.read<ManagerIvaCubit>().getIva();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("Discount ${widget.model.discountPrice}");
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
              BlocListener<CategoryCubit, CategoryState>(
                listener: (context, state) {
                  if (state.status == CategoryEnum.success) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.categoryUpdatedSuccessText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(
                        context, RoutesNames.categoryScreen);
                  }
                  if (state.error != const CustomError(error: '')) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      state.error.error,
                      AppColors.redColor,
                      Icons.close,
                      true,
                    );
                  }
                },
                child: BlocBuilder<CategoryCubit, CategoryState>(
                    builder: (context, state) {
                  if (state.status == CategoryEnum.loading) {
                    return LoadingIndicator.loading();
                  }
                  return CustomButton(
                    text: AppStrings.updateText,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        Map map = {
                          "name": categoryNameController.text,
                          "default_price": defaultPriceController.text,
                          "min_value": minValueContoller.text,
                          "max_value": maxValueController.text,
                          "discount_value": discountPriceContoller.text,
                          "iva_type": ivaType.toString(),
                          "iva_aliquota": aliquotaIva.toString(),
                          "is_active": status == "Active" ? "true" : "false",
                        };

                        await context
                            .read<CategoryCubit>()
                            .editCategory(widget.model.categoryId, map);
                      }
                    },
                  );
                }),
              ),
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
          CustomTextField(
            controller: discountPriceContoller,
            labelText: AppStrings.discountPriceText,
            hintText: AppStrings.enterDiscountPriceText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideDiscountPriceText;
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
            itemsMap: CategoryViewModel.ivaTypeList.map((v) {
              return DropdownMenuItem(
                value: v,
                child: Text(v.toString()),
              );
            }).toList(),
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
            itemsMap: CategoryViewModel.statusList.map((v) {
              return DropdownMenuItem(
                value: v,
                child: Text(v.toString()),
              );
            }).toList(),
            validationText: AppStrings.provideStatusText,
            onChanged: (v) {
              setState(() {
                status = v;
              });
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.aliquotaIVAText),
          BlocBuilder<ManagerIvaCubit, ManagerIvaState>(
              builder: (context, state) {
            return CustomDropDownWidget(
              hintText: AppStrings.aliquotaIVAText,
              value: aliquotaIva,
              validationText: AppStrings.provideAliquotaIvaText,
              onChanged: (v) {
                setState(() {
                  aliquotaIva = v;
                });
              },
              itemsMap: state.modelList.map((v) {
                return DropdownMenuItem(
                  value: v.id,
                  child: Text(v.value.toString()),
                );
              }).toList(),
            );
          }),
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
