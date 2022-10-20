// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_drop_down.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/common/loading_indicator.dart';
import 'package:grocery/Presentation/common/snack_bar_widget.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/navigation.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/product_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/bloc/resource_action_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/resource_action_view_model.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/resource_actions_screen.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resources/bloc/resource_cubit.dart';

import '../../../../../../../Data/errors/custom_error.dart';
import '../../../../../../common/custom_date_picker.dart';
import '../../../../../../common/date_picker.dart';
import '../../../../../../resources/routes/routes_names.dart';

class AddResourceActionScreen extends StatefulWidget {
  final ResourceData resourceData;

  const AddResourceActionScreen({
    super.key,
    required this.resourceData,
  });

  @override
  State<AddResourceActionScreen> createState() =>
      _AddResourceActionScreenState();
}

class _AddResourceActionScreenState extends State<AddResourceActionScreen> {
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
    actionType = ResourceActionViewModel.actionTypeList[0].toString();
    resourceController.text = widget.resourceData.name;
    getResource();
    super.initState();
  }

  getResource() async {
    if (widget.resourceData.isInventoryAction == true) {
      Future.wait([
        context.read<ResourceCubit>().getResource(),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.addResourceActionText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              textFields(),
              BlocListener<ResourceActionCubit, ResourceActionState>(
                listener: (context, state) {
                  if (state.status == ResourceActionEnum.success) {
                    if (widget.resourceData.isInventoryAction == true) {
                      Navigator.of(context).pop();
                      Navigate.toReplace(
                          context, const ResourceActionsScreen());
                      // Navigator.pushReplacementNamed(
                      //     context, RoutesNames.resourceActionsScreen);
                      SnackBarWidget.buildSnackBar(
                        context,
                        AppStrings.resourceActionAddedSuccessText,
                        AppColors.greenColor,
                        Icons.check,
                        true,
                      );
                    } else {
                      Navigator.of(context).pop();
                      SnackBarWidget.buildSnackBar(
                        context,
                        AppStrings.resourceActionAddedSuccessText,
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
                },
                child: BlocBuilder<ResourceActionCubit, ResourceActionState>(
                    builder: (context, state) {
                  if (state.status == ResourceActionEnum.loading) {
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
                          "is_for_internal_usage":
                              isInternalUsage == false ? "false" : "true",
                          "resource":
                              widget.resourceData.isInventoryAction == true
                                  ? allResources.toString()
                                  : "${widget.resourceData.id}",
                          "money_type": moneyType.toString(),
                        };
                        log("map $map");
                        context
                            .read<ResourceActionCubit>()
                            .addResourceAction(map);
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
          textFieldUpperText(AppStrings.selectActionTypeText),
          CustomDropDownWidget(
            hintText: AppStrings.actionTypeText,
            value: actionType,
            itemsMap: ResourceActionViewModel.actionTypeList.map((v) {
              return DropdownMenuItem(
                value: v,
                child: Text(v.toString()),
              );
            }).toList(),
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
            textInputType: TextInputType.number,
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
            textInputType: TextInputType.number,
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
            itemsMap: ResourceActionViewModel.moneyTypeList.map((v) {
              return DropdownMenuItem(
                value: v,
                child: Text(v.toString()),
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
            textInputType: TextInputType.number,
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
          if (widget.resourceData.isInventoryAction == true)
            BlocBuilder<ResourceCubit, ResourceState>(
                builder: (context, state) {
              return CustomDropDownWidget(
                hintText: AppStrings.resourceText,
                value: allResources,
                itemsMap: state.resourceModel.map((v) {
                  return DropdownMenuItem(
                    value: v.resourceId,
                    child: Text(v.resourceName.toString()),
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
          if (widget.resourceData.isInventoryAction == false)
            AbsorbPointer(
              absorbing: true,
              child: CustomTextField(
                controller: resourceController,
                labelText: AppStrings.resourceText,
                hintText: AppStrings.enterResourceText,
                suffixIcon: const Text(""),
                obscureText: false,
                textInputType: TextInputType.number,
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
          CustomSizedBox.height(15),
          internalUsage(),
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
