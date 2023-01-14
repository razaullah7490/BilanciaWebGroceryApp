// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:grocery/Application/exports.dart';

import '../../../../../../../Application/functions.dart';

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

  final keyModifierController = TextEditingController();
  final idGruppoController = TextEditingController();
  final idAuxLanController = TextEditingController();
  final tipoScontoController = TextEditingController();
  bool isBattSingola = false;

  @override
  void initState() {
    categoryNameController.text = widget.model.categoryName;
    discountPriceContoller.text = widget.model.discountPrice.toString();
    defaultPriceController.text = widget.model.defaultPrice.toString();
    minValueContoller.text = widget.model.minPrice.toString();
    maxValueController.text = widget.model.maxPrice.toString();
    ivaType = widget.model.ivaType.toString();
    status = widget.model.status == true ? "Attivo" : "Inattivo";
    aliquotaIva = widget.model.aliquotaIva;
    keyModifierController.text = widget.model.keyModifier.toString();
    idGruppoController.text = widget.model.idGruppo.toString();
    idAuxLanController.text = widget.model.idAuxLan.toString();
    tipoScontoController.text = widget.model.tipoSconto.toString();
    isBattSingola = widget.model.battSingola;
    context.read<ManagerIvaCubit>().getIva();
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
                    Navigate.toReplace(context, const CategoryScreen());
                    // Navigator.pushReplacementNamed(
                    //     context, RoutesNames.categoryScreen);
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
                          "is_active": status == "Attivo" ? "true" : "false",
                          "key_modifier": keyModifierController.text.toString(),
                          "id_gruppo": idGruppoController.text.toString(),
                          "batt_singola":
                              isBattSingola == true ? "true" : "false",
                          "id_aux_lan": idAuxLanController.text.toString(),
                          "tipo_sconto": tipoScontoController.text.toString(),
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
            initialValue: widget.model.defaultPrice.toString(),
            labelText: AppStrings.defaultPriceText,
            hintText: AppStrings.enterDefaultPriceText,
            suffixIcon: const Text(""),
            obscureText: false,
            onChanged: (v) {
              commaReplaceToDot(defaultPriceController, v);
            },
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            initialValue: widget.model.minPrice.toString(),
            labelText: AppStrings.minValueText,
            hintText: AppStrings.enterMinValueText,
            suffixIcon: const Text(""),
            obscureText: false,
            onChanged: (v) {
              commaReplaceToDot(minValueContoller, v);
            },
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            initialValue: widget.model.maxPrice.toString(),
            labelText: AppStrings.maxValueText,
            hintText: AppStrings.enterMaxValueText,
            suffixIcon: const Text(""),
            obscureText: false,
            onChanged: (v) {
              commaReplaceToDot(maxValueController, v);
            },
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            initialValue: widget.model.discountPrice.toString(),
            labelText: AppStrings.discountPriceText,
            hintText: AppStrings.enterDiscountPriceText,
            suffixIcon: const Text(""),
            obscureText: false,
            onChanged: (v) {
              commaReplaceToDot(discountPriceContoller, v);
            },
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
          CustomSizedBox.height(20),
          CustomTextField(
            initialValue: widget.model.keyModifier.toString(),
            labelText: AppStrings.keyModifierText,
            hintText: AppStrings.enterKeyModifierText,
            suffixIcon: const Text(""),
            obscureText: false,
            onChanged: (v) {
              commaReplaceToDot(keyModifierController, v);
            },
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideKeyModifierText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            initialValue: widget.model.idGruppo.toString(),
            labelText: AppStrings.idGruppoText,
            hintText: AppStrings.enterIdGruppoText,
            suffixIcon: const Text(""),
            obscureText: false,
            onChanged: (v) {
              commaReplaceToDot(idGruppoController, v);
            },
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideIdGruppoText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(10),
          battSingolaWidget(),
          CustomSizedBox.height(10),
          CustomTextField(
            initialValue: widget.model.idAuxLan.toString(),
            labelText: AppStrings.idAuxLanText,
            hintText: AppStrings.enterIdAuxLanText,
            suffixIcon: const Text(""),
            obscureText: false,
            onChanged: (v) {
              commaReplaceToDot(idAuxLanController, v);
            },
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideIdAuxLanText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            initialValue: widget.model.tipoSconto.toString(),
            labelText: AppStrings.tipoScontoText,
            hintText: AppStrings.enterTipoScontoText,
            suffixIcon: const Text(""),
            obscureText: false,
            onChanged: (v) {
              commaReplaceToDot(tipoScontoController, v);

            },
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideTipoScontoText;
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

  Widget battSingolaWidget() {
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
              value: isBattSingola,
              onChanged: (value) {
                setState(() {
                  isBattSingola = value!;
                });
              },
            ),
          ),
        ),
        CustomSizedBox.width(10),
        Padding(
          padding: const EdgeInsets.only(top: AppSize.p9).r,
          child: textFieldUpperText(AppStrings.battSingolaText),
        ),
      ],
    );
  }
}
