// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/bar_code_scan.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_drop_down.dart';
import 'package:grocery/Presentation/common/snack_bar_widget.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/proceedResource/proceed_resource_view_model.dart';
import '../../../../../../../Domain/models/inventory/proceed_resource_model.dart';
import '../../../../../../common/custom_date_picker.dart';
import '../../../../../../common/custom_text_field.dart';
import '../../../../../../common/date_picker.dart';
import '../../../../../../common/loading_indicator.dart';
import '../../../../../../resources/app_strings.dart';
import '../../../../../../resources/colors_palette.dart';
import '../../../../../../resources/size.dart';
import '../../../../../../resources/text_styles.dart';
import '../../category/category_view_model.dart';
import '../bloc/proceed_resource_cubit.dart';

class AddProceedResource extends StatefulWidget {
  const AddProceedResource({super.key});

  @override
  State<AddProceedResource> createState() => _AddProceedResourceState();
}

class _AddProceedResourceState extends State<AddProceedResource> {
  final formKey = GlobalKey<FormState>();
  final resourceNameController = TextEditingController();
  final aliquotaIvaContoller = TextEditingController();
  final stockQuantityController = TextEditingController();
  final stockQuantityThresholdController = TextEditingController();
  final pluController = TextEditingController();
  final shelfLifeController = TextEditingController();
  final unitSalePriceController = TextEditingController();
  final revenuePercentageController = TextEditingController();
  final barCodeController = TextEditingController();
  final tareController = TextEditingController();
  var ivaType;
  var measureUnit;
  var category;
  var status;
  var weightType;
  var ingrediant;
  String packagingDate = "";
  String expirationDate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.addProccedResourceText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //textFields(),
              CustomSizedBox.height(40),
              BlocBuilder<ProceedResourceCubit, ProceedResourceState>(
                  builder: (context, state) {
                if (state.status == ProceedResourceEnum.loading) {
                  return LoadingIndicator.loading();
                }

                return CustomButton(
                  text: AppStrings.addProccedText,
                  onTap: () async {
                    Random random = Random();
                    int randomNumber = random.nextInt(100);
                    if (formKey.currentState!.validate()) {
                      await context
                          .read<ProceedResourceCubit>()
                          .addProccedResource(
                            ProceedResourcesModel(
                              resourceId: randomNumber,
                              resourceName: resourceNameController.text,
                              aliquotaIva: int.parse(aliquotaIvaContoller.text),
                              ivaType: ivaType.toString(),
                              stockQuantity:
                                  double.parse(stockQuantityController.text),
                              stockQuantityThreshold: double.parse(
                                  stockQuantityThresholdController.text),
                              measureUnit: measureUnit.toString(),
                              barCode: barCodeController.text,
                              plu: double.parse(pluController.text),
                              shelfLife: double.parse(shelfLifeController.text),
                              unitSalePrice:
                                  double.parse(unitSalePriceController.text),
                              revenuePercentage: double.parse(
                                  revenuePercentageController.text),
                              category: category.toString(),
                              status: status.toString(),
                              tare: double.parse(tareController.text),
                              weightType: weightType,
                              ingrediant: ingrediant,
                              expirationDate: expirationDate.toString(),
                              packagingDate: packagingDate.toString(),
                            ),
                          );
                      Navigator.of(context).pop();
                      SnackBarWidget.buildSnackBar(
                        context,
                        AppStrings.proceedResourceAddedSuccessText,
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

  // Widget textFields() {
  //   return Form(
  //     key: formKey,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         CustomSizedBox.height(30),
  //         textFieldUpperText(AppStrings.resourceNameText),
  //         CustomTextField(
  //           controller: resourceNameController,
  //           labelText: AppStrings.resourceNameText,
  //           hintText: AppStrings.enterResourceNameText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.text,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideResourceNameText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.aliquotaIVAText),
  //         CustomTextField(
  //           controller: aliquotaIvaContoller,
  //           labelText: AppStrings.aliquotaIVAText,
  //           hintText: AppStrings.enterAliquotaIvaText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideAliquotaIvaText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.selectIvaTypeText),
  //         CustomDropDownWidget(
  //           hintText: AppStrings.ivaTypeText,
  //           value: ivaType,
  //           itemsList: CategoryViewModel.ivaTypeList,
  //           validationText: AppStrings.provideIVAtypeText,
  //           onChanged: (v) {
  //             setState(() {
  //               ivaType = v;
  //             });
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.stockQuantityText),
  //         CustomTextField(
  //           controller: stockQuantityController,
  //           labelText: AppStrings.stockQuantityText,
  //           hintText: AppStrings.enterStockQuantityText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideStockQuantityText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.stockQuantityThresholdText),
  //         CustomTextField(
  //           controller: stockQuantityThresholdController,
  //           labelText: AppStrings.stockQuantityThresholdText,
  //           hintText: AppStrings.enterStockQuantityThresholdText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideStockQuantityThresholdText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.measureUnitText),
  //         CustomDropDownWidget(
  //           hintText: AppStrings.measureUnitText,
  //           value: measureUnit,
  //           itemsList: CategoryViewModel.measureUnitList,
  //           validationText: AppStrings.provideMeasureUnitText,
  //           onChanged: (v) {
  //             setState(() {
  //               measureUnit = v;
  //             });
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.barcodeText),
  //         CustomTextField(
  //           controller: barCodeController,
  //           labelText: AppStrings.barcodeText,
  //           hintText: AppStrings.scanACodeText,
  //           suffixIcon: BarcodeScanWidget(barCodeController: barCodeController),
  //           obscureText: false,
  //           textInputType: TextInputType.text,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.providBarCodeText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.pluText),
  //         CustomTextField(
  //           controller: pluController,
  //           labelText: AppStrings.pluText,
  //           hintText: AppStrings.enterPluText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.providePluText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.shelfLifeText),
  //         CustomTextField(
  //           controller: shelfLifeController,
  //           labelText: AppStrings.shelfLifeText,
  //           hintText: AppStrings.enterShelfLifeText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideShelfLifeText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.unitSalePriceText),
  //         CustomTextField(
  //           controller: unitSalePriceController,
  //           labelText: AppStrings.unitSalePriceText,
  //           hintText: AppStrings.enterUnitSalePriceText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideUnitSalePriceText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.revenuePercentageText),
  //         CustomTextField(
  //           controller: revenuePercentageController,
  //           labelText: AppStrings.revenuePercentageText,
  //           hintText: AppStrings.enterRevenuePercentageText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideRevenuePercentageText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.categoryText),
  //         CustomDropDownWidget(
  //           hintText: AppStrings.categoryText,
  //           value: category,
  //           itemsList: CategoryViewModel.dummyCategoryList,
  //           validationText: AppStrings.provideCategoryText,
  //           onChanged: (v) {
  //             setState(() {
  //               category = v;
  //             });
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.statusText),
  //         CustomDropDownWidget(
  //           hintText: AppStrings.statusText,
  //           value: status,
  //           itemsList: CategoryViewModel.statusList,
  //           validationText: AppStrings.provideStatusText,
  //           onChanged: (v) {
  //             setState(() {
  //               status = v;
  //             });
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.tareText),
  //         CustomTextField(
  //           controller: tareController,
  //           labelText: AppStrings.tareText,
  //           hintText: AppStrings.enterTareText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideTareText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.weightTypeText),
  //         CustomDropDownWidget(
  //           hintText: AppStrings.weightTypeText,
  //           value: weightType,
  //           itemsList: ProcessedResourceViewModel.weightTypeList,
  //           validationText: AppStrings.provideWeightTypeText,
  //           onChanged: (v) {
  //             setState(() {
  //               weightType = v;
  //             });
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.ingredientsText),
  //         CustomDropDownWidget(
  //           hintText: AppStrings.ingredientsText,
  //           value: ingrediant,
  //           itemsList: ProcessedResourceViewModel.dummyIngrediantsList,
  //           validationText: AppStrings.provideIngredientText,
  //           onChanged: (v) {
  //             setState(() {
  //               ingrediant = v;
  //             });
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.packagingDateText),
  //         CustomDatePickerWidget(
  //           date: packagingDate,
  //           onTap: () async {
  //             var newDate = await datePicker(context);
  //             setState(() {
  //               packagingDate = newDate!;
  //             });
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.expirationDateText),
  //         CustomDatePickerWidget(
  //           date: expirationDate,
  //           onTap: () async {
  //             var newDate = await datePicker(context);
  //             setState(() {
  //               expirationDate = newDate!;
  //             });
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
