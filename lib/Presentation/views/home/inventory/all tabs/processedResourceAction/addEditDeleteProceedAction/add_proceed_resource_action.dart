// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

import '../../../../../../../Domain/models/inventory/proceed_resource_action_model.dart';
import '../../../../../../common/loading_indicator.dart';
import '../../../../../../common/snack_bar_widget.dart';
import '../bloc/proceed_resource_action_cubit.dart';

class AddProceedResourceActionScreen extends StatefulWidget {
  const AddProceedResourceActionScreen({super.key});

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
              //textFields(),
              BlocBuilder<ProceedResourceActionCubit,
                  ProceedResourceActionState>(
                builder: (context, state) {
                  if (state.status == ProceedResourceActionEnum.loading) {
                    return LoadingIndicator.loading();
                  }
                  return CustomButton(
                    text: AppStrings.addActionText,
                    onTap: () async {
                      Random random = Random();
                      int randomNumber = random.nextInt(100);
                      if (formKey.currentState!.validate()) {
                        await context
                            .read<ProceedResourceActionCubit>()
                            .addProceedResourceAction(
                                ProcessedResourceActionModel(
                              processedresourceActionId: randomNumber,
                              processedresourceActionName:
                                  actionType.toString(),
                              quantity: double.parse(quantityController.text),
                              money: double.parse(moneyController.text),
                              priceCounter:
                                  double.parse(printCounterController.text),
                              resource: resourceController.text,
                              isForInternalUsage: isInternalUsage,
                            ));
                        Navigator.of(context).pop();
                        SnackBarWidget.buildSnackBar(
                          context,
                          AppStrings.proceedResourceActionAddedSuccessText,
                          AppColors.greenColor,
                          Icons.check,
                          true,
                        );
                      }
                    },
                  );
                },
              ),
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
  //         textFieldUpperText(AppStrings.selectActionTypeText),
  //         CustomDropDownWidget(
  //           hintText: AppStrings.actionTypeText,
  //           value: actionType,
  //           itemsList: ResourceActionViewModel.actionTypeList,
  //           validationText: AppStrings.provideActionTypeText,
  //           onChanged: (v) {
  //             setState(() {
  //               actionType = v;
  //             });
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.quantityOnlyText),
  //         CustomTextField(
  //           controller: quantityController,
  //           labelText: AppStrings.quantityOnlyText,
  //           hintText: AppStrings.enterQuantityText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideQuantityText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.moneyText),
  //         CustomTextField(
  //           controller: moneyController,
  //           labelText: AppStrings.moneyText,
  //           hintText: AppStrings.enterMoneyText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideMoneyText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.priceCounterText),
  //         CustomTextField(
  //           controller: printCounterController,
  //           labelText: AppStrings.priceCounterText,
  //           hintText: AppStrings.enterPriceCounterText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.providePriceCounterText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(20),
  //         textFieldUpperText(AppStrings.resourceText),
  //         CustomTextField(
  //           controller: resourceController,
  //           labelText: AppStrings.resourceText,
  //           hintText: AppStrings.enterResourceText,
  //           suffixIcon: const Text(""),
  //           obscureText: false,
  //           textInputType: TextInputType.number,
  //           isLabel: false,
  //           validator: (v) {
  //             if (v!.trim().isEmpty) {
  //               return AppStrings.provideResourceText;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         CustomSizedBox.height(15),
  //         internalUsage(),
  //         CustomSizedBox.height(30),
  //       ],
  //     ),
  //   );
  // }

  // Widget internalUsage() {
  //   return Row(
  //     children: [
  //       SizedBox(
  //         width: 20.w,
  //         child: Theme(
  //           data: Theme.of(context).copyWith(
  //             unselectedWidgetColor: AppColors.primaryColor,
  //           ),
  //           child: Checkbox(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(
  //                     Radius.circular(AppBorderRadius.checkBoxRadius.r))),
  //             activeColor: AppColors.primaryColor,
  //             value: isInternalUsage,
  //             onChanged: (value) {
  //               setState(() {
  //                 isInternalUsage = value!;
  //               });
  //             },
  //           ),
  //         ),
  //       ),
  //       CustomSizedBox.width(10),
  //       Padding(
  //         padding: const EdgeInsets.only(top: AppSize.p9).r,
  //         child: textFieldUpperText(AppStrings.isForInternalUsageText),
  //       ),
  //     ],
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
