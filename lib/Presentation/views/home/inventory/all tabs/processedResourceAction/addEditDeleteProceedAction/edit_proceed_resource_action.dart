// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Domain/models/proceed_resource_action_model.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_drop_down.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/resource_action_view_model.dart';
import '../../../../../../common/loading_indicator.dart';
import '../../../../../../common/snack_bar_widget.dart';
import '../bloc/proceed_resource_action_cubit.dart';

class EditProceedResourceAction extends StatefulWidget {
  final ProcessedResourceActionModel model;
  const EditProceedResourceAction({
    super.key,
    required this.model,
  });

  @override
  State<EditProceedResourceAction> createState() =>
      _EditProceedResourceActionState();
}

class _EditProceedResourceActionState extends State<EditProceedResourceAction> {
  final formKey = GlobalKey<FormState>();
  final quantityController = TextEditingController();
  final moneyController = TextEditingController();
  final printCounterController = TextEditingController();
  final resourceController = TextEditingController();
  var actionType;
  bool isInternalUsage = false;
  @override
  void initState() {
    actionType = widget.model.processedresourceActionName;
    quantityController.text = widget.model.quantity.toString();
    moneyController.text = widget.model.money.toString();
    printCounterController.text = widget.model.priceCounter.toString();
    resourceController.text = widget.model.resource;
    isInternalUsage = widget.model.isForInternalUsage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.editProcessedResourceActionText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              textFields(),
              BlocBuilder<ProceedResourceActionCubit,
                  ProceedResourceActionState>(builder: (context, state) {
                if (state.status == ProceedResourceActionEnum.loading) {
                  return LoadingIndicator.loading();
                }
                return CustomButton(
                  text: AppStrings.updateText,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await context
                          .read<ProceedResourceActionCubit>()
                          .editProceedResourceAction(
                            widget.model.processedresourceActionId,
                            ProcessedResourceActionModel(
                              processedresourceActionId:
                                  widget.model.processedresourceActionId,
                              processedresourceActionName:
                                  actionType.toString(),
                              quantity: double.parse(quantityController.text),
                              money: double.parse(moneyController.text),
                              priceCounter:
                                  double.parse(printCounterController.text),
                              resource: resourceController.text,
                              isForInternalUsage: isInternalUsage,
                            ),
                          );
                      Navigator.of(context).pop();
                      SnackBarWidget.buildSnackBar(
                        context,
                        AppStrings.proceedResourceActionUpdatedSuccessText,
                        AppColors.greenColor,
                        Icons.check,
                        true,
                      );
                    }
                  },
                );
              }),
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
            itemsList: ResourceActionViewModel.actionTypeList,
            validationText: AppStrings.provideActionTypeText,
            onChanged: (v) {
              setState(() {
                actionType = v;
              });
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: quantityController,
            labelText: AppStrings.quantityOnlyText,
            hintText: AppStrings.enterQuantityText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideQuantityText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: moneyController,
            labelText: AppStrings.moneyText,
            hintText: AppStrings.enterMoneyText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideMoneyText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: printCounterController,
            labelText: AppStrings.priceCounterText,
            hintText: AppStrings.enterPriceCounterText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.providePriceCounterText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: resourceController,
            labelText: AppStrings.resourceText,
            hintText: AppStrings.enterResourceText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideResourceText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(10),
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
