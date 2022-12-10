// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:developer';
import 'package:grocery/Application/exports.dart';

class AddResourceScreen extends StatefulWidget {
  const AddResourceScreen({super.key});

  @override
  State<AddResourceScreen> createState() => _AddResourceScreenState();
}

class _AddResourceScreenState extends State<AddResourceScreen> {
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

  addNoSelect() async {
    await context.read<IngredientsCubit>().getIngredients();
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
    Future.wait([
      context.read<CategoryCubit>().getCategory(),
      //context.read<IngredientsCubit>().getIngredients(),
      context.read<ManagerIvaCubit>().getIva(),
    ]);
    addNoSelect();
    stockQuantityController.text = "0";
    stockQuantityThresholdController.text = "0";
    measureUnit = CategoryViewModel.measureUnitList[0].toString();
    shelfLifeController.text = "7";
    status = CategoryViewModel.statusList[0].toString();
    tareController.text = "0";
    weightType = ProcessedResourceViewModel.weightTypeModelList[0].id;
    threshold1Controller.text = "0";
    threshold2Controller.text = "0";
    price1Controller.text = "0";
    price2Controller.text = "0";
    traceability = ProcessedResourceViewModel.traceabilityModelList[0].id;
    traceabilityIdController.text = "0";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.addResourceText,
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
                ],
              ),
              CustomSizedBox.height(40),
              BlocListener<ResourceCubit, ResourceState>(
                listener: (context, state) {
                  if (state.status == ResourceEnum.success) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.resourceAddedSuccessText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                    Navigator.of(context).pop();
                    Navigate.toReplace(context, const ResorucesScreen());
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
                child: BlocBuilder<ResourceCubit, ResourceState>(
                    builder: (context, state) {
                  if (state.status == ResourceEnum.loading) {
                    return LoadingIndicator.loading();
                  }

                  return CustomButton(
                    text: AppStrings.addResourceText,
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
                        };

                        var formData = FormData.fromMap(map);

                        if (image != null) {
                          formData.files.add(MapEntry("image",
                              MultipartFile.fromFileSync(image!.path)));
                        }

                        log("RESPONSE $map");

                        await context
                            .read<ResourceCubit>()
                            .addResource(formData);
                        log("map $formData");
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
            controller: revenuePercentageController,
            labelText: AppStrings.revenuePercentageText,
            hintText: AppStrings.enterRevenuePercentageText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
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
            itemsMap: ProcessedResourceViewModel.weightTypeModelList.map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.text),
              );
            }).toList(),
            // itemsMap: ProcessedResourceViewModel.weightTypeList.map((v) {
            //   return DropdownMenuItem(
            //     value: v,
            //     child: Text(v.toString()),
            //   );
            // }).toList(),
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
              hintText: AppStrings.ingredientsText,
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
            itemsMap: ProcessedResourceViewModel.traceabilityModelList.map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.text),
              );
            }).toList(),
            // itemsMap: ProcessedResourceViewModel.traceabilityList.map((v) {
            //   return DropdownMenuItem(
            //     value: v,
            //     child: Text(v.toString()),
            //   );
            // }).toList(),
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
}
