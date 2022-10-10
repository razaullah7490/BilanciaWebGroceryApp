import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Data/services/auth/change_password.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/common/snack_bar_widget.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/changePassword/Bloc/change_password_cubit.dart';
import '../../../../../../../Data/errors/custom_error.dart';
import '../../../../../../common/loading_indicator.dart';
import '../../../../../../resources/size.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.changePasswordText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p15).r,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomSizedBox.height(30),
              textFields(),
              CustomSizedBox.height(50),
              BlocListener<ChangePasswordCubit, ChangePasswordState>(
                listener: (context, state) {
                  if (state.status == ChangePasswordEnum.success) {
                    Navigator.of(context).pop();
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.passwordUpdatedSuccessText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
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
                child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  builder: (context, state) {
                    if (state.status == ChangePasswordEnum.loading) {
                      return LoadingIndicator.loading();
                    }

                    return CustomButton(
                      text: AppStrings.updateText,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          Map<String, dynamic> map = {
                            "old_password": currentPasswordController.text,
                            "new_password": confirmNewPasswordController.text,
                          };

                          context
                              .read<ChangePasswordCubit>()
                              .changePassword(map);
                        }
                      },
                    );
                  },
                ),
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
          text(AppStrings.enterCurrentPasswordText),
          CustomSizedBox.height(15),
          CustomTextField(
            controller: currentPasswordController,
            labelText: AppStrings.currentPasswordText,
            hintText: AppStrings.enterCurrentPasswordText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideCurrentPasswordText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(30),
          text(AppStrings.setNewPasswordText2),
          CustomSizedBox.height(15),
          CustomTextField(
            controller: newPasswordController,
            labelText: AppStrings.newPasswordText,
            hintText: AppStrings.enterNewPasswordText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideNewPasswordText;
              } else if (v.length < 6) {
                return AppStrings.passwordLengthText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(15),
          CustomTextField(
            controller: confirmNewPasswordController,
            labelText: AppStrings.confirmPasswordText,
            hintText: AppStrings.enterConfirmPasswordText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideConfirmPasswordText;
              } else if (v != newPasswordController.text) {
                return AppStrings.passwordNotMatch;
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Text text(String text) {
    return Text(
      text,
      style: Styles.circularStdBook(
        AppSize.text15.sp,
        AppColors.containerTextColor,
      ),
    );
  }
}
