// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
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
import 'package:image_picker/image_picker.dart';

import '../../../../../../../Data/errors/custom_error.dart';
import '../../../../../../../Domain/models/inventory/resources_model.dart';
import '../../../../../../common/custom_bottom_sheet.dart';
import '../../../../../../common/custom_date_picker.dart';
import '../../../../../../common/date_picker.dart';
import '../../../../../../common/image_picker.dart';
import '../../../../../../common/loading_indicator.dart';
import '../../../../../../resources/border_radius.dart';
import '../../../../../../resources/routes/navigation.dart';
import '../../../../../../resources/routes/routes_names.dart';
import '../../../../../../resources/size.dart';
import '../../../../../../state management/bloc/ingredientsBloc/ingredients_cubit.dart';
import '../../../../../../state management/bloc/ivaBloc/manager_iva_cubit.dart';
import '../../category/bloc/category_cubit.dart';
import '../../proceedResource/proceed_resource_view_model.dart';
import '../resources_screen.dart';

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
  final stockQuantityController = TextEditingController();
  final stockQuantityThresholdController = TextEditingController();
  final pluController = TextEditingController();
  final shelfLifeController = TextEditingController();
  final unitSalePriceController = TextEditingController();
  final revenuePercentageController = TextEditingController();
  final barCodeController = TextEditingController();
  final tareController = TextEditingController();
  final unitPurchasePriceController = TextEditingController();
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

  final threshold1Controller = TextEditingController();
  final threshold2Controller = TextEditingController();
  final price1Controller = TextEditingController();
  final price2Controller = TextEditingController();
  bool isFlgConfig = false;
  var traceability;
  final traceabilityIdController = TextEditingController();

  @override
  void initState() {
    resourceNameController.text = widget.model.resourceName;
    pluController.text = widget.model.plu.toString();
    shelfLifeController.text = widget.model.shelfLife.toString();
    unitSalePriceController.text = widget.model.unitSalePrice.toString();
    stockQuantityThresholdController.text =
        widget.model.stockQuantityThreshold.toString();

    revenuePercentageController.text =
        widget.model.revenuePercentage.toString();
    barCodeController.text = widget.model.barCode.toString();
    stockQuantityController.text = widget.model.stockQuantity.toString();
    ivaType = widget.model.ivaType;
    measureUnit = widget.model.measureUnit;
    category = widget.model.category;
    aliquotaIva = widget.model.aliquotaIva;
    tareController.text = widget.model.tare.toString();
    weightType = widget.model.weightType.toString();
    expirationDate = widget.model.expirationDate.isNotEmpty
        ? DateTime.parse(widget.model.expirationDate)
        : expirationDate;
    packagingDate = widget.model.packagingDate.isNotEmpty
        ? DateTime.parse(widget.model.packagingDate)
        : packagingDate;

    unitPurchasePriceController.text =
        widget.model.unitPurchasePrice.toString();
    status = widget.model.status == true ? "Active" : "InActive";

    threshold1Controller.text = widget.model.threshold1.toString();
    threshold2Controller.text = widget.model.threshold2.toString();
    price1Controller.text = widget.model.price1.toString();
    price2Controller.text = widget.model.price2.toString();
    traceability = widget.model.traceability.toString();
    traceabilityIdController.text = widget.model.traceabilityId.toString();
    isFlgConfig = widget.model.flgConfig;

    Future.wait([
      context.read<CategoryCubit>().getCategory(),
      context.read<IngredientsCubit>().getIngredients(),
      context.read<ManagerIvaCubit>().getIva(),
    ]);
    ingrediant =
        widget.model.ingrediant != 0 ? widget.model.ingrediant : ingrediant;
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
              textFields(),
              CustomSizedBox.height(20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: textFieldUpperText(AppStrings.addImageText)),
              CustomSizedBox.height(5),
              Row(
                children: [
                  CustomBottomSheet(
                    onCameraTap: () async {
                      Navigator.of(context).pop();
                      var imagePath =
                          await CustomImagePicker.getImage(ImageSource.camera);
                      setState(() {
                        image = imagePath;
                      });
                    },
                    onGalleryTap: () async {
                      Navigator.of(context).pop();
                      var imagePath =
                          await CustomImagePicker.getImage(ImageSource.gallery);
                      setState(() {
                        image = imagePath;
                      });
                    },
                  ),
                  if (image != null) imageContainer(),
                  if (widget.model.image.isNotEmpty && image == null)
                    oldImage(),
                ],
              ),
              CustomSizedBox.height(40),
              BlocListener<ResourceCubit, ResourceState>(
                listener: (context, state) {
                  if (state.status == ResourceEnum.success) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.resourceUpdatedSuccessText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                    Navigator.of(context).pop();
                    Navigate.toReplace(context, const ResorucesScreen());
                    // Navigator.pushReplacementNamed(
                    //     context, RoutesNames.resourcesScreen);
                  }

                  if (state.error != const CustomError(error: '')) {
                    log("state error ${state.error.error}");
                    SnackBarWidget.buildSnackBar(
                      context,
                      state.error.error,
                      AppColors.redColor,
                      Icons.close,
                      true,
                    );
                  }
                },
                child: BlocBuilder<ResourceCubit, ResourceState>(
                    builder: (context, state) {
                  if (state.status == ResourceEnum.loading) {
                    return LoadingIndicator.loading();
                  }
                  return CustomButton(
                    text: AppStrings.editResourceText,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        Map<String, dynamic> map = {
                          "name": resourceNameController.text,
                          "category": category.toString(),
                          "iva_aliquota": aliquotaIva.toString(),
                          "iva_type": ivaType.toString(),
                          "stock_quantity":
                              stockQuantityController.text.toString(),
                          "stock_quantity_threshold":
                              stockQuantityThresholdController.text.toString(),
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
                              : "",
                          "packaging_date": packagingDate != null
                              ? packagingDate.toString()
                              : "",
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
                        };

                        log("map $map");

                        var formData = FormData.fromMap(map);
                        if (image != null) {
                          formData.files.add(MapEntry("image",
                              MultipartFile.fromFileSync(image!.path)));
                        }

                        await context
                            .read<ResourceCubit>()
                            .editResource(widget.model.resourceId, formData);
                        log("formData $formData");
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

  CachedNetworkImage oldImage() {
    return CachedNetworkImage(
      imageUrl: widget.model.image,
      imageBuilder: (context, imageProvider) => Container(
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
          child: Image(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => LoadingIndicator.loading(),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        size: AppSize.icon28.r,
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

  Widget textFields() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox.height(30),
          CustomTextField(
            controller: resourceNameController,
            labelText: AppStrings.resourceNameText,
            hintText: AppStrings.enterResourceNameText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideResourceNameText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
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
          CustomTextField(
            controller: stockQuantityController,
            labelText: AppStrings.stockQuantityText,
            hintText: AppStrings.enterStockQuantityText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideStockQuantityText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: stockQuantityThresholdController,
            labelText: AppStrings.stockQuantityThresholdText,
            hintText: AppStrings.enterStockQuantityThresholdText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
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
          CustomTextField(
            controller: barCodeController,
            labelText: AppStrings.barcodeText,
            hintText: AppStrings.scanACodeText,
            suffixIcon: BarcodeScanWidget(barCodeController: barCodeController),
            obscureText: false,
            textInputType: TextInputType.text,
            validator: (v) {
              // if (v!.trim().isEmpty) {
              //   return AppStrings.providBarCodeText;
              // } else {
              //   return null;
              // }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: pluController,
            labelText: AppStrings.pluText,
            hintText: AppStrings.enterPluText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.providePluText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: shelfLifeController,
            labelText: AppStrings.shelfLifeText,
            hintText: AppStrings.enterShelfLifeText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideShelfLifeText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: unitSalePriceController,
            labelText: AppStrings.unitSalePriceText,
            hintText: AppStrings.enterUnitSalePriceText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideUnitSalePriceText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: unitPurchasePriceController,
            labelText: AppStrings.unitPurchasePriceText,
            hintText: AppStrings.enterUnitPurchasePriceText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              // if (v!.trim().isEmpty) {
              //   return AppStrings.provideUnitPurchasePriceText;
              // } else {
              //   return null;
              // }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: revenuePercentageController,
            labelText: AppStrings.revenuePercentageText,
            hintText: AppStrings.enterRevenuePercentageText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              // if (v!.trim().isEmpty) {
              //   return AppStrings.provideRevenuePercentageText;
              // } else {
              //   return null;
              // }
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
          CustomTextField(
            controller: threshold1Controller,
            labelText: AppStrings.threshold1Text,
            hintText: AppStrings.enterThreshold1Text,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideThreshold1Text;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: threshold2Controller,
            labelText: AppStrings.threshold2Text,
            hintText: AppStrings.enterThreshold2Text,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideThreshold2Text;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: price1Controller,
            labelText: AppStrings.price1Text,
            hintText: AppStrings.enterPrice1Text,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.providePrice1Text;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: price2Controller,
            labelText: AppStrings.price2Text,
            hintText: AppStrings.enterPrice2Text,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
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
          CustomTextField(
            controller: traceabilityIdController,
            labelText: AppStrings.traceabilityIdText,
            hintText: AppStrings.enterTraceabilityIdText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideTraceabilityIdText;
              } else {
                return null;
              }
            },
          ),
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
}
