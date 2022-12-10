// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:developer';
import 'package:grocery/Application/exports.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
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
    context.read<ManagerIvaCubit>().getIva();
    initialControllers();
    super.initState();
  }

  initialControllers() {
    keyModifierController.text = "0";
    idGruppoController.text = "1";
    idAuxLanController.text = "0";
    tipoScontoController.text = "0";
  }

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
              BlocListener<CategoryCubit, CategoryState>(
                listener: (context, state) {
                  if (state.status == CategoryEnum.success) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.categoryAddedSuccessText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                    Navigator.of(context).pop();
                    Navigate.toReplace(context, const CategoryScreen());
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
                    builder: ((context, state) {
                  if (state.status == CategoryEnum.loading) {
                    return LoadingIndicator.loading();
                  }

                  return CustomButton(
                    text: AppStrings.addCategoryText,
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

                        log("map $map");

                        await context.read<CategoryCubit>().addCategory(map);
                      }
                    },
                  );
                })),
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
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideMaxValueText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.discountPriceText),
          CustomTextField(
            controller: discountPriceContoller,
            labelText: AppStrings.discountPriceText,
            hintText: AppStrings.enterDiscountPriceText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            isLabel: false,
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
          textFieldUpperText(AppStrings.keyModifierText),
          CustomTextField(
            controller: keyModifierController,
            labelText: AppStrings.keyModifierText,
            hintText: AppStrings.enterKeyModifierText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideKeyModifierText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.idGruppoText),
          CustomTextField(
            controller: idGruppoController,
            labelText: AppStrings.idGruppoText,
            hintText: AppStrings.enterIdGruppoText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            isLabel: false,
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
          textFieldUpperText(AppStrings.idAuxLanText),
          CustomTextField(
            controller: idAuxLanController,
            labelText: AppStrings.idAuxLanText,
            hintText: AppStrings.enterIdAuxLanText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideIdAuxLanText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.tipoScontoText),
          CustomTextField(
            controller: tipoScontoController,
            labelText: AppStrings.tipoScontoText,
            hintText: AppStrings.enterTipoScontoText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            isLabel: false,
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
