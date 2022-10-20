// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, unused_local_variable
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/bar_code_scan.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_drop_down.dart';
import 'package:grocery/Presentation/common/snack_bar_widget.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/proceedResource/proceed_resource_screen.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/proceedResource/proceed_resource_view_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../../Data/errors/custom_error.dart';
import '../../../../../../../Data/services/manager/proceed_resource_service.dart';
import '../../../../../../../Domain/models/inventory/proceed_resource_model.dart';
import '../../../../../../../Domain/models/inventory/resources_model.dart';
import '../../../../../../common/custom_bottom_sheet.dart';
import '../../../../../../common/custom_date_picker.dart';
import '../../../../../../common/custom_text_field.dart';
import '../../../../../../common/date_picker.dart';
import '../../../../../../common/image_picker.dart';
import '../../../../../../common/loading_indicator.dart';
import '../../../../../../resources/app_strings.dart';
import '../../../../../../resources/border_radius.dart';
import '../../../../../../resources/colors_palette.dart';
import '../../../../../../resources/routes/navigation.dart';
import '../../../../../../resources/routes/routes_names.dart';
import '../../../../../../resources/size.dart';
import '../../../../../../resources/text_styles.dart';
import '../../../../../../state management/bloc/ingredientsBloc/ingredients_cubit.dart';
import '../../../../../../state management/bloc/ivaBloc/manager_iva_cubit.dart';
import '../../category/bloc/category_cubit.dart';
import '../../category/category_view_model.dart';
import '../../resources/bloc/resource_cubit.dart';
import '../bloc/proceed_resource_cubit.dart';

class AddProceedResource extends StatefulWidget {
  const AddProceedResource({super.key});

  @override
  State<AddProceedResource> createState() => _AddProceedResourceState();
}

class _AddProceedResourceState extends State<AddProceedResource> {
  final formKey = GlobalKey<FormState>();
  final resourceNameController = TextEditingController();
  final stockQuantityController = TextEditingController();
  final stockQuantityThresholdController = TextEditingController();
  final pluController = TextEditingController();
  final shelfLifeController = TextEditingController();
  final unitSalePriceController = TextEditingController();
  final revenuePercentageController = TextEditingController();
  final barCodeController = TextEditingController();
  final tareController = TextEditingController();
  final unitPurchasePriceController = TextEditingController();
  final threshold1Controller = TextEditingController();
  final threshold2Controller = TextEditingController();
  final price1Controller = TextEditingController();
  final price2Controller = TextEditingController();
  final traceabilityIdController = TextEditingController();
  var ivaType;
  var measureUnit;
  var category;
  var weightType;
  var ingrediant;
  DateTime? packagingDate;
  DateTime? expirationDate;
  var aliquotaIva;
  var status;
  File? image;
  bool isFlgConfig = false;
  var traceability;

  List<Map> madeWithList = List.empty(growable: true);
  List<TextEditingController> controllers = List.empty(growable: true);
  List resourceIds = [];

  @override
  void initState() {
    Future.wait([
      context.read<CategoryCubit>().getCategory(),
      context.read<IngredientsCubit>().getIngredients(),
      context.read<ManagerIvaCubit>().getIva(),
      context.read<ResourceCubit>().getResource(),
    ]);
    stockQuantityController.text = "0";
    stockQuantityThresholdController.text = "0";
    measureUnit = CategoryViewModel.measureUnitList[0].toString();
    shelfLifeController.text = "7";
    status = CategoryViewModel.statusList[0].toString();
    tareController.text = "0";
    weightType = ProcessedResourceViewModel.weightTypeList[0].toString();
    threshold1Controller.text = "0";
    threshold2Controller.text = "0";
    price1Controller.text = "0";
    price2Controller.text = "0";
    traceability = ProcessedResourceViewModel.traceabilityList[0].toString();
    traceabilityIdController.text = "0";
    unitPurchasePriceController.text = "0";
    revenuePercentageController.text = "0";
    //allListWidget();
    super.initState();
  }

  allListWidget() {
    final controller = TextEditingController();
    var ids;
    setState(() {
      controllers.add(controller);
      resourceIds.add(ids);
    });
  }

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
              textFields(),
              CustomSizedBox.height(40),
              BlocListener<ProceedResourceCubit, ProceedResourceState>(
                listener: (context, state) {
                  if (state.status == ProceedResourceEnum.success) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.proceedResourceAddedSuccessText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                    Navigator.of(context).pop();
                    Navigate.to(context, const ProceedResourceScreen());
                    // Navigator.pushReplacementNamed(
                    //     context, RoutesNames.proceedResourceScreen);
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
                child: BlocBuilder<ProceedResourceCubit, ProceedResourceState>(
                    builder: (context, state) {
                  if (state.status == ProceedResourceEnum.loading) {
                    return LoadingIndicator.loading();
                  }

                  return CustomButton(
                    text: AppStrings.addProccedText,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (controllers.isEmpty && resourceIds.isEmpty) {
                          SnackBarWidget.buildSnackBar(
                            context,
                            AppStrings.addAtleastOneText,
                            AppColors.redColor,
                            Icons.close,
                            true,
                          );
                        } else {
                          madeWithList = [];

                          for (var i = 0; i < controllers.length; i++) {
                            madeWithList.add({
                              "resource_percentage_used":
                                  controllers[i].text.toString(),
                              "resource": resourceIds[i].toString()
                            });
                          }

                          log("MADE WITH $madeWithList");

                          Map<String, dynamic> map = {
                            "name": resourceNameController.text,
                            "category": category.toString(),
                            "iva_aliquota": aliquotaIva.toString(),
                            "iva_type": ivaType.toString(),
                            "stock_quantity":
                                stockQuantityController.text.toString(),
                            "stock_quantity_threshold":
                                stockQuantityThresholdController.text
                                    .toString(),
                            "measure_unit": measureUnit.toString(),
                            "barcode": barCodeController.text.toString(),
                            "unit_sale_price":
                                unitSalePriceController.text.toString(),
                            "plu": pluController.text.toString(),
                            "tare": tareController.text.toString(),
                            "weight_type": weightType.toString(),
                            "ingredient": ingrediant.toString(),
                            "revenue_percentage":
                                revenuePercentageController.text.toString(),
                            "expiration_date": expirationDate != null
                                ? expirationDate.toString()
                                : null,
                            "packaging_date": packagingDate != null
                                ? packagingDate.toString()
                                : null,
                            "unit_purchase_price":
                                unitPurchasePriceController.text.toString(),
                            "is_active": status == "Active" ? "true" : "false",
                            "threshold_1": threshold1Controller.text.toString(),
                            "threshold_2": threshold2Controller.text.toString(),
                            "price_1": price1Controller.text.toString(),
                            "price_2": price2Controller.text.toString(),
                            "flg_config": isFlgConfig,
                            "traceability": traceability.toString(),
                            "traceability_id":
                                traceabilityIdController.text.toString(),
                            "made_with": madeWithList,
                          };

                          await context
                              .read<ProceedResourceCubit>()
                              .addProccedResource(map);
                        }
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
          textFieldUpperText(AppStrings.resourceNameText),
          CustomTextField(
            controller: resourceNameController,
            labelText: AppStrings.resourceNameText,
            hintText: AppStrings.enterResourceNameText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideResourceNameText;
              } else {
                return null;
              }
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
          textFieldUpperText(AppStrings.stockQuantityText),
          CustomTextField(
            controller: stockQuantityController,
            labelText: AppStrings.stockQuantityText,
            hintText: AppStrings.enterStockQuantityText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideStockQuantityText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.stockQuantityThresholdText),
          CustomTextField(
            controller: stockQuantityThresholdController,
            labelText: AppStrings.stockQuantityThresholdText,
            hintText: AppStrings.enterStockQuantityThresholdText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideStockQuantityThresholdText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.measureUnitText),
          CustomDropDownWidget(
            hintText: AppStrings.measureUnitText,
            value: measureUnit,
            itemsMap: CategoryViewModel.measureUnitList.map((v) {
              return DropdownMenuItem(
                value: v,
                child: Text(v.toString()),
              );
            }).toList(),
            validationText: AppStrings.provideMeasureUnitText,
            onChanged: (v) {
              setState(() {
                measureUnit = v;
              });
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.barcodeText),
          CustomTextField(
            controller: barCodeController,
            labelText: AppStrings.barcodeText,
            hintText: AppStrings.scanACodeText,
            suffixIcon: BarcodeScanWidget(barCodeController: barCodeController),
            obscureText: false,
            textInputType: TextInputType.text,
            isLabel: false,
            validator: (v) {
              // if (v!.trim().isEmpty) {
              //   return AppStrings.providBarCodeText;
              // } else {
              //   return null;
              // }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.pluText),
          CustomTextField(
            controller: pluController,
            labelText: AppStrings.pluText,
            hintText: AppStrings.enterPluText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.providePluText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.shelfLifeText),
          CustomTextField(
            controller: shelfLifeController,
            labelText: AppStrings.shelfLifeText,
            hintText: AppStrings.enterShelfLifeText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideShelfLifeText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.unitSalePriceText),
          CustomTextField(
            controller: unitSalePriceController,
            labelText: AppStrings.unitSalePriceText,
            hintText: AppStrings.enterUnitSalePriceText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideUnitSalePriceText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.unitPurchasePriceText),
          CustomTextField(
            controller: unitPurchasePriceController,
            labelText: AppStrings.unitPurchasePriceText,
            hintText: AppStrings.enterUnitPurchasePriceText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideUnitPurchasePriceText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.revenuePercentageText),
          CustomTextField(
            controller: revenuePercentageController,
            labelText: AppStrings.revenuePercentageText,
            hintText: AppStrings.enterRevenuePercentageText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideRevenuePercentageText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.categoryText),
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
            return CustomDropDownWidget(
              hintText: AppStrings.categoryText,
              value: category,
              itemsMap: state.categoryModel.map((v) {
                return DropdownMenuItem(
                  value: v.categoryId,
                  child: Text(v.categoryName),
                );
              }).toList(),
              validationText: AppStrings.provideCategoryText,
              onChanged: (v) {
                setState(() {
                  category = v;
                });
              },
            );
          }),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.statusText),
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
          textFieldUpperText(AppStrings.tareText),
          CustomTextField(
            controller: tareController,
            labelText: AppStrings.tareText,
            hintText: AppStrings.enterTareText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideTareText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.weightTypeText),
          CustomDropDownWidget(
            hintText: AppStrings.weightTypeText,
            value: weightType,
            itemsMap: ProcessedResourceViewModel.weightTypeList.map((v) {
              return DropdownMenuItem(
                value: v,
                child: Text(v.toString()),
              );
            }).toList(),
            validationText: AppStrings.provideWeightTypeText,
            onChanged: (v) {
              setState(() {
                weightType = v;
              });
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.ingredientsText),
          BlocBuilder<IngredientsCubit, IngredientsState>(
              builder: (context, state) {
            return CustomDropDownWidget(
              hintText: AppStrings.ingredientsText,
              value: ingrediant,
              itemsMap: state.modelList.map((v) {
                return DropdownMenuItem(
                  value: v.ingrediantId,
                  child: Text(v.description.toString()),
                );
              }).toList(),
              validationText: AppStrings.provideIngredientText,
              onChanged: (v) {
                setState(() {
                  ingrediant = v;
                });
              },
            );
          }),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.packagingDateText),
          CustomDatePickerWidget(
            date: packagingDate,
            onTap: () async {
              var newDate = await datePicker(context);
              setState(() {
                packagingDate = newDate;
              });
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.expirationDateText),
          CustomDatePickerWidget(
            date: expirationDate,
            onTap: () async {
              var newDate = await datePicker(context);
              setState(() {
                expirationDate = newDate;
              });
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.threshold1Text),
          CustomTextField(
            controller: threshold1Controller,
            labelText: AppStrings.threshold1Text,
            hintText: AppStrings.enterThreshold1Text,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideThreshold1Text;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.threshold2Text),
          CustomTextField(
            controller: threshold2Controller,
            labelText: AppStrings.threshold2Text,
            hintText: AppStrings.enterThreshold2Text,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideThreshold2Text;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.price1Text),
          CustomTextField(
            controller: price1Controller,
            labelText: AppStrings.price1Text,
            hintText: AppStrings.enterPrice1Text,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.providePrice1Text;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.price2Text),
          CustomTextField(
            controller: price2Controller,
            labelText: AppStrings.price2Text,
            hintText: AppStrings.enterPrice2Text,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.providePrice2Text;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(10),
          flyConfigWidget(),
          CustomSizedBox.height(10),
          textFieldUpperText(AppStrings.traceabilityText),
          CustomDropDownWidget(
            hintText: AppStrings.traceabilityText,
            value: traceability,
            itemsMap: ProcessedResourceViewModel.traceabilityList.map((v) {
              return DropdownMenuItem(
                value: v,
                child: Text(v.toString()),
              );
            }).toList(),
            validationText: AppStrings.provideTraceabilityText,
            onChanged: (v) {
              setState(() {
                traceability = v;
              });
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.traceabilityIdText),
          CustomTextField(
            controller: traceabilityIdController,
            labelText: AppStrings.traceabilityIdText,
            hintText: AppStrings.enterTraceabilityIdText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideTraceabilityIdText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          tableRowWidget(),
          // Align(
          //     alignment: Alignment.centerLeft,
          //     child: textFieldUpperText(AppStrings.addImageText)),
          // CustomSizedBox.height(5),
          // Row(
          //   children: [
          //     CustomBottomSheet(
          //       onCameraTap: () async {
          //         Navigator.of(context).pop();
          //         var imagePath =
          //             await CustomImagePicker.getImage(ImageSource.camera);
          //         setState(() {
          //           image = imagePath;
          //         });
          //       },
          //       onGalleryTap: () async {
          //         Navigator.of(context).pop();
          //         var imagePath =
          //             await CustomImagePicker.getImage(ImageSource.gallery);
          //         setState(() {
          //           image = imagePath;
          //         });
          //       },
          //     ),
          //     if (image != null) imageContainer(),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget flyConfigWidget() {
    return Row(
      children: [
        SizedBox(
          width: 20.w,
          child: Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: AppColors.primaryColor,
            ),
            child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppBorderRadius.checkBoxRadius.r))),
              activeColor: AppColors.primaryColor,
              value: isFlgConfig,
              onChanged: (value) {
                setState(() {
                  isFlgConfig = value!;
                });
              },
            ),
          ),
        ),
        CustomSizedBox.width(10),
        Padding(
          padding: const EdgeInsets.only(top: AppSize.p9).r,
          child: textFieldUpperText(AppStrings.flgConfigText),
        ),
      ],
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

  Widget imageContainer() {
    return Container(
      padding: const EdgeInsets.all(AppSize.p6).r,
      margin: const EdgeInsets.symmetric(horizontal: AppSize.m15).r,
      width: 120.w,
      height: 110.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.secondaryColor,
          width: 1.5.w,
        ),
        borderRadius: BorderRadius.circular(
          AppBorderRadius.chooseImageContainerRadius.r,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppBorderRadius.chooseImageContainerRadius.r,
        ),
        child: Image.file(
          image!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget tableRowWidget() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
                child: tableText(AppStrings.resourceAndResourcePercentageText)),
            CustomSizedBox.width(15),
            addResourceButton(),
          ],
        ),
        CustomSizedBox.height(15),
        Padding(
          padding: const EdgeInsets.only(bottom: AppSize.p10).r,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controllers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSize.p10).r,
                child: Row(
                  children: [
                    Flexible(
                      child: BlocBuilder<ResourceCubit, ResourceState>(
                          builder: (context, state) {
                        return DropdownButtonFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null) {
                              return AppStrings.selectResourceText;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            errorMaxLines: 1,
                            contentPadding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 12, bottom: 12)
                                .r,
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                        AppBorderRadius.dropDownBorderRadius)
                                    .r,
                                borderSide: BorderSide(
                                  color: AppColors.redColor2,
                                  width: 1.w,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                        AppBorderRadius.dropDownBorderRadius)
                                    .r,
                                borderSide: BorderSide(
                                  color: AppColors.secondaryColor,
                                  width: 1.w,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                        AppBorderRadius.dropDownBorderRadius)
                                    .r,
                                borderSide: BorderSide(
                                  color: AppColors.secondaryColor,
                                  width: 1.w,
                                )),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                        AppBorderRadius.dropDownBorderRadius)
                                    .r,
                                borderSide: BorderSide(
                                  color: AppColors.secondaryColor,
                                  width: 1.w,
                                )),
                          ),
                          hint: Text(
                            AppStrings.resourceText,
                            style: Styles.circularStdBook(
                              AppSize.text14.sp,
                              AppColors.hintTextColor,
                            ),
                          ),
                          dropdownColor: Colors.white,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.secondaryColor,
                          ),
                          iconSize: AppSize.icon28.r,
                          isExpanded: true,
                          style: Styles.circularStdMedium(
                            AppSize.text14.sp,
                            AppColors.primaryColor,
                          ),
                          value: resourceIds[index],
                          items: state.resourceModel.map((v) {
                            return DropdownMenuItem(
                              value: v.resourceId,
                              child: Text(
                                v.resourceName.toString(),
                                maxLines: 1,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (v) {
                            setState(() {
                              resourceIds[index] = v;
                            });
                          },
                        );
                      }),
                    ),
                    CustomSizedBox.width(10),
                    Flexible(
                      child: CustomTextField(
                        controller: controllers[index],
                        labelText: AppStrings.percentageText,
                        hintText: AppStrings.percentageUsedText,
                        suffixIcon: SizedBox(
                          width: 10.w,
                          height: 10.h,
                          child: Center(
                            child: Text(
                              "%",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                        obscureText: false,
                        textInputType: TextInputType.number,
                        isLabel: false,
                        validator: (v) {
                          if (v!.trim().isEmpty) {
                            return AppStrings.providePercentageText;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    CustomSizedBox.width(10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          controllers.removeAt(index);
                          resourceIds.removeAt(index);
                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Icon(
                        Icons.delete,
                        color: AppColors.redColor2,
                        size: 27.r,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget tableText(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.p2,
      ).r,
      child: Text(
        text,
        maxLines: 2,
        style: Styles.circularStdBook(
          AppSize.text15.sp,
          AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget addResourceButton() {
    return Container(
      width: 30.w,
      height: 30.h,
      decoration: const BoxDecoration(
        color: AppColors.addProductContainerColor,
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
          onTap: () {
            allListWidget();
          },
          behavior: HitTestBehavior.opaque,
          child: Center(child: Icon(Icons.add, size: 20.r))),
    );
  }
}
