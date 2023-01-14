// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_null_aware_operators
import 'dart:developer';
import 'package:grocery/Application/exports.dart';

import '../../../../../../../Application/functions.dart';

class EditProceedResourceScreen extends StatefulWidget {
  final ProceedResourcesModel model;
  const EditProceedResourceScreen({
    super.key,
    required this.model,
  });

  @override
  State<EditProceedResourceScreen> createState() =>
      _EditProceedResourceScreenState();
}

class _EditProceedResourceScreenState extends State<EditProceedResourceScreen> {
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
  List controllers = List.empty(growable: true);
  List resourceIds = [];
  List resourceNames = List.empty(growable: true);

  addNoSelect() async {
    await context.read<IngredientsCubit>().getIngredients();
    ingrediant =
        widget.model.ingredient != 0 ? widget.model.ingredient : ingrediant;
    var ingredientList = context.read<IngredientsCubit>().state.modelList;
    ingredientList.insert(
      0,
      IngredientModel(
        ingrediantId: 0,
        description: AppStrings.noSelectIngredientText,
      ),
    );
  }

  @override
  void initState() {
    resourceNameController.text = widget.model.name!;
    pluController.text = widget.model.plu.toString();
    shelfLifeController.text = widget.model.shelfLife.toString();
    unitSalePriceController.text = widget.model.unitSalePrice.toString();
    stockQuantityThresholdController.text =
        widget.model.stockQuantityThreshold.toString();
    aliquotaIva = widget.model.ivaAliquota;
    revenuePercentageController.text =
        widget.model.revenuePercentage.toString();
    barCodeController.text = widget.model.barcode.toString();
    stockQuantityController.text = widget.model.stockQuantity.toString();
    ivaType = widget.model.ivaType;
    status = widget.model.isActive == true ? "Attivo" : "Inattivo";
    measureUnit = widget.model.measureUnit;
    category = widget.model.category;
    tareController.text = widget.model.tare.toString();
    weightType = widget.model.weightType ?? weightType;
    // ingrediant = widget.model.ingredient;
    expirationDate = widget.model.expirationDate != "null"
        ? DateTime.parse(widget.model.expirationDate!)
        : expirationDate;
    packagingDate = widget.model.packagingDate != "null"
        ? DateTime.parse(widget.model.packagingDate!)
        : packagingDate;
    unitPurchasePriceController.text =
        widget.model.unitPurchasePrice.toString();
    threshold1Controller.text = widget.model.threshold1.toString();
    threshold2Controller.text = widget.model.threshold2.toString();
    price1Controller.text = widget.model.price1.toString();
    price2Controller.text = widget.model.price2.toString();
    isFlgConfig = widget.model.flgConfig!;
    traceability = widget.model.traceability;
    traceabilityIdController.text = widget.model.traceabilityId.toString();
    madeWithList = widget.model.madeWith!;

    Future.wait([
      context.read<CategoryCubit>().getCategory(),
      //context.read<IngredientsCubit>().getIngredients(),
      context.read<ManagerIvaCubit>().getIva(),
      context.read<ResourceCubit>().getResource(),
    ]).whenComplete(() => setState(() => addFields()));

    addNoSelect();
    super.initState();
  }

  addFields() {
    var resouceModel = context.read<ResourceCubit>().state.resourceModel;
    log("Model $resouceModel");

    for (var i = 0; i < madeWithList.length; i++) {
      var data = resouceModel
          .where((element) =>
              element.resourceId.toString() ==
              madeWithList[i]['resource'].toString())
          .toList();

      log("Data $data");

      var controllerText = TextEditingController();
      controllerText.text =
          madeWithList[i]['resource_percentage_used'].toString();
      controllers.add(controllerText);
      resourceIds.add(madeWithList[i]['resource']);
      resourceNames.addAll(data.map((e) => e.resourceName).toList());
      log("Resource Name $resourceNames");
    }
  }

  allListWidget() {
    final controller = TextEditingController();
    var ids;
    String resourceName = "Select";
    setState(() {
      controllers.add(controller);
      resourceIds.add(ids);
      resourceNames.add(resourceName);
    });
  }

  @override
  Widget build(BuildContext context) {
    log("Made With $madeWithList");
    log("ID ${widget.model.id}");
    for (var i = 0; i < madeWithList.length; i++) {
      log("MadeWith ${madeWithList[i]['resource_percentage_used']}");
    }
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.editProceedResourceText,
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
                      AppStrings.proceedResourceUpdatedSuccessText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                    Navigator.of(context).pop();
                    Navigate.toReplace(context, const ProceedResourceScreen());
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
                    text: AppStrings.updateText,
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
                            "ingredient": ingrediant == null || ingrediant == 0
                                ? ""
                                : ingrediant.toString(),
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
                            "is_active": status == "Attivo" ? "true" : "false",
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
                          log("Map $map");
                          await context
                              .read<ProceedResourceCubit>()
                              .editProceedResource(widget.model.id, map);
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
            // controller: stockQuantityController,
            initialValue: widget.model.stockQuantity.toString(),
            onChanged: (v) {
              commaReplaceToDot(stockQuantityController, v);
            },
            labelText: AppStrings.stockQuantityText,
            hintText: AppStrings.enterStockQuantityText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            // controller: stockQuantityThresholdController,
            initialValue: widget.model.stockQuantityThreshold.toString(),
            onChanged: (v) {
              commaReplaceToDot(stockQuantityThresholdController, v);
            },
            labelText: AppStrings.stockQuantityThresholdText,
            hintText: AppStrings.enterStockQuantityThresholdText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            suffixIcon: BarcodeScanWidget(onTap: () {
              Navigate.to(context, BarcodeScanner(
                getBarcode: (barcode) {
                  log("Barcode $barcode");
                  setState(() {
                    barCodeController.text = barcode;
                  });
                },
              ));
            }),
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
            // controller: pluController,
            initialValue: widget.model.plu.toString(),
            onChanged: (v) {
              commaReplaceToDot(pluController, v);
            },
            labelText: AppStrings.pluText,
            hintText: AppStrings.enterPluText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            initialValue: widget.model.shelfLife.toString(),
            onChanged: (v) {
              commaReplaceToDot(shelfLifeController, v);
            },
            // controller: shelfLifeController,
            labelText: AppStrings.shelfLifeText,
            hintText: AppStrings.enterShelfLifeText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            // controller: unitSalePriceController,
            onChanged: (v) {
              commaReplaceToDot(unitSalePriceController, v);
            },
            initialValue: widget.model.unitSalePrice.toString(),

            labelText: AppStrings.unitSalePriceText,
            hintText: AppStrings.enterUnitSalePriceText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            onChanged: (v) {
              commaReplaceToDot(unitPurchasePriceController, v);
            },
            initialValue: widget.model.unitPurchasePrice.toString(),

            // controller: unitPurchasePriceController,
            labelText: AppStrings.unitPurchasePriceText,
            hintText: AppStrings.enterUnitPurchasePriceText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            isLabel: false,
            validator: (v) {
              // if (v!.trim().isEmpty) {
              //   return AppStrings.provideUnitPurchasePriceText;
              // } else {
              //   return null;
              // }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.revenuePercentageText),
          CustomTextField(
            initialValue: widget.model.revenuePercentage.toString(),
            onChanged: (v) {
              commaReplaceToDot(revenuePercentageController, v);
            },

            // controller: revenuePercentageController,
            labelText: AppStrings.revenuePercentageText,
            hintText: AppStrings.enterRevenuePercentageText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            isLabel: false,
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
            // controller: tareController,
            initialValue: widget.model.tare.toString(),
            onChanged: (v) {
              commaReplaceToDot(tareController, v);
            },

            labelText: AppStrings.tareText,
            hintText: AppStrings.enterTareText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            value: weightType.toString(),
            itemsMap: ProcessedResourceViewModel.weightTypeModelList.map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.text),
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
            return WithOutValidationDropDown(
              hintText: widget.model.ingredient == null
                  ? AppStrings.noSelectIngredientText
                  : AppStrings.ingredientsText,
              value: ingrediant,
              itemsMap: state.modelList.map((v) {
                return DropdownMenuItem(
                  value: v.ingrediantId,
                  child: Text(
                    v.description.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.circularStdBook(
                      AppSize.text14.sp,
                      v.description == AppStrings.noSelectIngredientText
                          ? AppColors.textColor
                          : AppColors.primaryColor,
                    ),
                  ),
                );
              }).toList(),
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
            // controller: threshold1Controller,
            initialValue: widget.model.threshold1.toString(),
            onChanged: (v) {
              commaReplaceToDot(threshold1Controller, v);
            },
            labelText: AppStrings.threshold1Text,
            hintText: AppStrings.enterThreshold1Text,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            // controller: threshold2Controller,
            initialValue: widget.model.threshold2.toString(),
            onChanged: (v) {
              commaReplaceToDot(threshold2Controller, v);
            },
            labelText: AppStrings.threshold2Text,
            hintText: AppStrings.enterThreshold2Text,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            // controller: price1Controller,
            initialValue: widget.model.price1.toString(),
            onChanged: (v) {
              commaReplaceToDot(price1Controller, v);
            },
            labelText: AppStrings.price1Text,
            hintText: AppStrings.enterPrice1Text,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            // controller: price2Controller,
            initialValue: widget.model.price2.toString(),
            onChanged: (v) {
              commaReplaceToDot(price2Controller, v);
            },
            labelText: AppStrings.price2Text,
            hintText: AppStrings.enterPrice2Text,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            value: traceability.toString(),
            itemsMap: ProcessedResourceViewModel.traceabilityModelList.map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.text),
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
            initialValue: widget.model.traceabilityId.toString(),
            onChanged: (v) {
              commaReplaceToDot(traceabilityIdController, v);
            },
            // controller: traceabilityIdController,
            labelText: AppStrings.traceabilityIdText,
            hintText: AppStrings.enterTraceabilityIdText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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

  Widget tableRowWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tableBoldText(AppStrings.compositionText),
                CustomSizedBox.height(5),
                tableText(AppStrings.resourceAndResourcePercentageText),
              ],
            ),
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
                        return SingleSearchableDialogue(
                          hintText: resourceNames[index].toString(),
                          value: resourceIds[index],
                          itemsMap: state.resourceModel
                              .map((e) => DropdownMenuItem(
                                    enabled: false,
                                    value: e.resourceName,
                                    child: Text(
                                      e.resourceName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.segoeUI(
                                          15, AppColors.blackColor),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            var data = state.resourceModel.where(
                                (element) => element.resourceName == value);
                            log("Data $data");
                            setState(() {
                              resourceIds[index] =
                                  data.map((e) => e.resourceId).first;

                              resourceNames[index] =
                                  data.map((e) => e.resourceName).first;
                            });
                            log("ONCHANGE $resourceIds");
                          },
                        );
                      }),
                    ),
                    // Flexible(
                    //   child: BlocBuilder<ResourceCubit, ResourceState>(
                    //       builder: (context, state) {
                    //     return DropdownButtonFormField(
                    //       autovalidateMode: AutovalidateMode.onUserInteraction,
                    //       validator: (value) {
                    //         if (value == null) {
                    //           return AppStrings.selectResourceText;
                    //         } else {
                    //           return null;
                    //         }
                    //       },
                    //       decoration: InputDecoration(
                    //         errorMaxLines: 1,
                    //         contentPadding: const EdgeInsets.only(
                    //                 left: 16, right: 16, top: 12, bottom: 12)
                    //             .r,
                    //         errorBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(
                    //                     AppBorderRadius.dropDownBorderRadius)
                    //                 .r,
                    //             borderSide: BorderSide(
                    //               color: AppColors.redColor2,
                    //               width: 1.w,
                    //             )),
                    //         enabledBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(
                    //                     AppBorderRadius.dropDownBorderRadius)
                    //                 .r,
                    //             borderSide: BorderSide(
                    //               color: AppColors.secondaryColor,
                    //               width: 1.w,
                    //             )),
                    //         focusedBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(
                    //                     AppBorderRadius.dropDownBorderRadius)
                    //                 .r,
                    //             borderSide: BorderSide(
                    //               color: AppColors.secondaryColor,
                    //               width: 1.w,
                    //             )),
                    //         focusedErrorBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(
                    //                     AppBorderRadius.dropDownBorderRadius)
                    //                 .r,
                    //             borderSide: BorderSide(
                    //               color: AppColors.secondaryColor,
                    //               width: 1.w,
                    //             )),
                    //       ),
                    //       hint: Text(
                    //         AppStrings.resourceText,
                    //         style: Styles.circularStdBook(
                    //           AppSize.text14.sp,
                    //           AppColors.hintTextColor,
                    //         ),
                    //       ),
                    //       dropdownColor: Colors.white,
                    //       icon: const Icon(
                    //         Icons.keyboard_arrow_down,
                    //         color: AppColors.secondaryColor,
                    //       ),
                    //       iconSize: AppSize.icon28.r,
                    //       isExpanded: true,
                    //       style: Styles.circularStdMedium(
                    //         AppSize.text14.sp,
                    //         AppColors.primaryColor,
                    //       ),
                    //       value: resourceIds[index],
                    //       items: state.resourceModel.map((v) {
                    //         return DropdownMenuItem(
                    //           value: v.resourceId,
                    //           child: Text(
                    //             v.resourceName.toString(),
                    //             maxLines: 1,
                    //             style: const TextStyle(
                    //               overflow: TextOverflow.ellipsis,
                    //             ),
                    //           ),
                    //         );
                    //       }).toList(),
                    //       onChanged: (v) {
                    //         setState(() {
                    //           resourceIds[index] = v;
                    //         });
                    //       },
                    //     );
                    //   }),
                    // ),
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
                        textInputType: const TextInputType.numberWithOptions(decimal: true),
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

  Widget tableBoldText(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.p2,
      ).r,
      child: Text(
        text,
        maxLines: 1,
        style: Styles.circularStdMedium(
          AppSize.text16.sp,
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
