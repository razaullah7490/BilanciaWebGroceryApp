// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:developer';
import 'package:grocery/Application/exports.dart';

class AddProceedResourceActionScreen extends StatefulWidget {
  final ProceedResourceData model;
  const AddProceedResourceActionScreen({
    super.key,
    required this.model,
  });

  @override
  State<AddProceedResourceActionScreen> createState() =>
      _AddProceedResourceActionScreenState();
}

class _AddProceedResourceActionScreenState
    extends State<AddProceedResourceActionScreen> {
  final formKey = GlobalKey<FormState>();
  final quantityController = TextEditingController();
  final moneyController = TextEditingController();
  final printCounterController = TextEditingController();
  final resourceController = TextEditingController();
  var actionType;
  bool isInternalUsage = false;
  DateTime? dateTime;
  var moneyType;
  var allResources;

  @override
  void initState() {
    actionType =
        ResourceActionViewModel.proceedResourceActionTypeModelList[0].id;
    resourceController.text = widget.model.name;
    getProceedResource();
    super.initState();
  }

  getProceedResource() async {
    if (widget.model.isInventoryAction == true) {
      Future.wait([
        context.read<ProceedResourceCubit>().getProceedResource(),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.addActionText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              textFields(),
              BlocListener<ProceedResourceActionCubit,
                  ProceedResourceActionState>(listener: (context, state) {
                if (state.status == ProceedResourceActionEnum.success) {
                  if (widget.model.isInventoryAction == true) {
                    Navigator.of(context).pop();
                    Navigate.toReplace(
                        context, const ProcessedResourceActionScreen());

                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.proceedResourceActionAddedSuccessText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                  } else {
                    Navigator.of(context).pop();
                    Navigate.toReplace(context, const ProceedResourceScreen());
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.proceedResourceActionAddedSuccessText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                  }
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
              }, child: BlocBuilder<ProceedResourceActionCubit,
                  ProceedResourceActionState>(
                builder: (context, state) {
                  if (state.status == ProceedResourceActionEnum.loading) {
                    return LoadingIndicator.loading();
                  }
                  return CustomButton(
                    text: AppStrings.addActionText,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        Map map = {
                          "action_type": actionType.toString(),
                          "quantity": quantityController.text,
                          "money": moneyController.text,
                          "date_time":
                              dateTime != null ? dateTime.toString() : "",
                          "print_counter": printCounterController.text,
                          "is_for_internal_usage": "false",
                          //isInternalUsage == false ? "false" : "true",
                          "resource": widget.model.isInventoryAction == true
                              ? allResources.toString()
                              : "${widget.model.id}",
                          "money_type": moneyType.toString(),
                        };
                        log("map $map");

                        await context
                            .read<ProceedResourceActionCubit>()
                            .addProceedResourceAction(map);
                      }
                    },
                  );
                },
              )),
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
          textFieldUpperText(AppStrings.selectActionTypeText),
          CustomDropDownWidget(
            hintText: AppStrings.actionTypeText,
            value: actionType,
            itemsMap: ResourceActionViewModel.proceedResourceActionTypeModelList
                .map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.value),
              );
            }).toList(),
            // itemsMap:
            //     ResourceActionViewModel.proceedResourceActionTypeList.map((v) {
            //   return DropdownMenuItem(
            //     value: v.toString(),
            //     child: Text(v.toString()),
            //   );
            // }).toList(),
            validationText: AppStrings.provideActionTypeText,
            onChanged: (v) {
              setState(() {
                actionType = v;
              });
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.quantityOnlyText),
          CustomTextField(
            controller: quantityController,
            labelText: AppStrings.quantityOnlyText,
            hintText: AppStrings.enterQuantityText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideQuantityText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.moneyText),
          CustomTextField(
            controller: moneyController,
            labelText: AppStrings.moneyText,
            hintText: AppStrings.enterMoneyText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideMoneyText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.moneyTypeText),
          CustomDropDownWidget(
            hintText: AppStrings.moneyTypeText,
            value: moneyType,
            itemsMap: ResourceActionViewModel.moneyTypeModelList.map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.value),
              );
            }).toList(),
            validationText: AppStrings.provideMoneyTypeText,
            onChanged: (v) {
              setState(() {
                moneyType = v;
              });
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.dateText),
          CustomDatePickerWidget(
            date: dateTime,
            onTap: () async {
              var newDate = await datePicker(context);
              setState(() {
                dateTime = newDate;
              });
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.priceCounterText),
          CustomTextField(
            controller: printCounterController,
            labelText: AppStrings.priceCounterText,
            hintText: AppStrings.enterPriceCounterText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.providePriceCounterText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.resourceText),
          if (widget.model.isInventoryAction == true)
            BlocBuilder<ProceedResourceCubit, ProceedResourceState>(
                builder: (context, state) {
              return CustomDropDownWidget(
                hintText: AppStrings.resourceText,
                value: allResources,
                itemsMap: state.proceedResourceModel.map((v) {
                  return DropdownMenuItem(
                    value: v.id,
                    child: Text(v.name.toString()),
                  );
                }).toList(),
                validationText: AppStrings.provideResourceText,
                onChanged: (v) {
                  setState(() {
                    allResources = v;
                  });
                },
              );
            }),
          if (widget.model.isInventoryAction == false)
            AbsorbPointer(
              absorbing: true,
              child: CustomTextField(
                controller: resourceController,
                labelText: AppStrings.resourceText,
                hintText: AppStrings.enterResourceText,
                suffixIcon: const Text(""),
                obscureText: false,
                textInputType: const TextInputType.numberWithOptions(decimal: true),
                isLabel: false,
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return AppStrings.provideResourceText;
                  } else {
                    return null;
                  }
                },
              ),
            ),
          // CustomSizedBox.height(15),
          // internalUsage(),
          CustomSizedBox.height(30),
        ],
      ),
    );
  }

  Widget internalUsage() {
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
              value: isInternalUsage,
              onChanged: (value) {
                setState(() {
                  isInternalUsage = value!;
                });
              },
            ),
          ),
        ),
        CustomSizedBox.width(10),
        Padding(
          padding: const EdgeInsets.only(top: AppSize.p9).r,
          child: textFieldUpperText(AppStrings.isForInternalUsageText),
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
