// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/bar_code_scan.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_drop_down.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/common/snack_bar_widget.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/category_view_model.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resources/bloc/resource_cubit.dart';

import '../../../../../../../Domain/models/inventory/resources_model.dart';
import '../../../../../../resources/size.dart';

class EditResourceScreen extends StatefulWidget {
  final ResourcesModel model;
  const EditResourceScreen({
    super.key,
    required this.model,
  });

  @override
  State<EditResourceScreen> createState() => _EditResourceScreenState();
}

class _EditResourceScreenState extends State<EditResourceScreen> {
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
  var ivaType;
  var measureUnit;
  var category;
  var status;
  Pattern pattern = "-1";
  @override
  void initState() {
    resourceNameController.text = widget.model.resourceName;
    pluController.text = widget.model.plu.toString();
    shelfLifeController.text = widget.model.shelfLife.toString();
    unitSalePriceController.text = widget.model.unitSalePrice.toString();
    stockQuantityThresholdController.text =
        widget.model.stockQuantityThreshold.toString();
    aliquotaIvaContoller.text = widget.model.aliquotaIva.toString();
    revenuePercentageController.text =
        widget.model.revenuePercentage.toString();
    barCodeController.text = widget.model.barCode.toString();
    stockQuantityController.text = widget.model.stockQuantity.toString();
    ivaType = widget.model.ivaType;
    status = widget.model.status;
    measureUnit = widget.model.measureUnit;
    category = widget.model.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.editResourceText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //textFields(),
              CustomSizedBox.height(40),
              BlocBuilder<ResourceCubit, ResourceState>(
                  builder: (context, state) {
                return CustomButton(
                  text: AppStrings.editResourceText,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      context.read<ResourceCubit>().editResource(
                          widget.model.resourceId,
                          ResourcesModel(
                            resourceId: widget.model.resourceId,
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
                            revenuePercentage:
                                double.parse(revenuePercentageController.text),
                            category: category.toString(),
                            status: status.toString(),
                          ));
                      Navigator.of(context).pop();
                      SnackBarWidget.buildSnackBar(
                        context,
                        AppStrings.resourceUpdatedSuccessText,
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
  //         CustomTextField(
  //           controller: resourceNameController,
  //           labelText: AppStrings.resourceNameText,
  //           hintText: AppStrings.enterResourceNameText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.text,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideResourceNameText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         CustomTextField(
  //           controller: aliquotaIvaContoller,
  //           labelText: AppStrings.aliquotaIVAText,
  //           hintText: AppStrings.enterAliquotaIvaText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
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
  //         CustomTextField(
  //           controller: stockQuantityController,
  //           labelText: AppStrings.stockQuantityText,
  //           hintText: AppStrings.enterStockQuantityText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideStockQuantityText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         CustomTextField(
  //           controller: stockQuantityThresholdController,
  //           labelText: AppStrings.stockQuantityThresholdText,
  //           hintText: AppStrings.enterStockQuantityThresholdText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
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
  //         CustomTextField(
  //           controller: barCodeController,
  //           labelText: AppStrings.barcodeText,
  //           hintText: AppStrings.scanACodeText,
  //           suffixIcon: BarcodeScanWidget(barCodeController: barCodeController),
  //           obscureText: false,
  //           textInputType: TextInputType.text,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.providBarCodeText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         CustomTextField(
  //           controller: pluController,
  //           labelText: AppStrings.pluText,
  //           hintText: AppStrings.enterPluText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.providePluText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         CustomTextField(
  //           controller: shelfLifeController,
  //           labelText: AppStrings.shelfLifeText,
  //           hintText: AppStrings.enterShelfLifeText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideShelfLifeText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         CustomTextField(
  //           controller: unitSalePriceController,
  //           labelText: AppStrings.unitSalePriceText,
  //           hintText: AppStrings.enterUnitSalePriceText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideUnitSalePriceText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         CustomTextField(
  //           controller: revenuePercentageController,
  //           labelText: AppStrings.revenuePercentageText,
  //           hintText: AppStrings.enterRevenuePercentageText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
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
