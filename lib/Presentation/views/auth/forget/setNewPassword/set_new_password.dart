// ignore_for_file: use_build_context_synchronously

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Data/services/auth/forget_password_service.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/navigation.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/state%20management/bloc/set_bool_cubit.dart';
import 'package:grocery/Presentation/views/auth/common/screen_pattern.dart';
import 'package:grocery/Presentation/views/auth/forget/passwordRecovered/successfully_recoverd_password.dart';

import '../../../../../Data/errors/custom_error.dart';
import '../../../../common/loading_indicator.dart';
import '../../../../common/snack_bar_widget.dart';
import '../Bloc/forget_password_cubit.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;
  const SetNewPasswordScreen({
    super.key,
    required this.initialLink,
  });

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: Column(
        children: [
          CustomSizedBox.height(50),
          titleText(),
          CustomSizedBox.height(35),
          textFields(),
          CustomSizedBox.height(35),
          BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
            listener: ((context, state) {
              if (state.status == ForgetPasswordEnum.success) {
                SnackBarWidget.buildSnackBar(
                  context,
                  AppStrings.passwordChangedSuccessText,
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
            }),
            child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
              builder: ((context, state) {
                if (state.status == ForgetPasswordEnum.loading) {
                  return LoadingIndicator.loading();
                }
                return CustomButton(
                  text: AppStrings.doneText,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      Map<String, dynamic> map = {
                        "password": newPasswordController.text,
                        "password_2": confirmPasswordController.text,
                      };
                      var isValid = await context
                          .read<ForgetPasswordCubit>()
                          .passwordResetConfirm(
                            map,
                            widget.initialLink!.link.toString(),
                          );

                      if (isValid == true) {
                        Navigate.to(this.context,
                            const SuccessfullyRecoveredPasswordScreen());
                      }
                    }
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Text titleText() {
    return Text(
      AppStrings.setNewPasswordText,
      textAlign: TextAlign.center,
      style: Styles.circularStdMedium(
        AppSize.text30.sp,
        AppColors.blackColor,
        letterSpacing: 1,
      ),
    );
  }

  Widget textFields() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p22,
        ),
        child: Column(
          children: [
            BlocProvider(
              create: (context) => SetBoolCubit(false),
              child: BlocBuilder<SetBoolCubit, bool>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: newPasswordController,
                    labelText: AppStrings.newPasswordText,
                    hintText: AppStrings.enterNewPasswordText,
                    suffixIcon: IconButton(
                      onPressed: () => state
                          ? context.read<SetBoolCubit>().changeState(false)
                          : context.read<SetBoolCubit>().changeState(true),
                      icon: Icon(
                        state ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: 20.r,
                      ),
                    ),
                    obscureText: state,
                    textInputType: TextInputType.text,
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return AppStrings.provideNewPasswordText;
                      } else {
                        return null;
                      }
                    },
                  );
                },
              ),
            ),
            CustomSizedBox.height(25),
            BlocProvider(
              create: (context) => SetBoolCubit(false),
              child: BlocBuilder<SetBoolCubit, bool>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: confirmPasswordController,
                    labelText: AppStrings.confirmPasswordText,
                    hintText: AppStrings.enterConfirmPasswordText,
                    suffixIcon: IconButton(
                      onPressed: () => state
                          ? context.read<SetBoolCubit>().changeState(false)
                          : context.read<SetBoolCubit>().changeState(true),
                      icon: Icon(
                        state ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: 20.r,
                      ),
                    ),
                    obscureText: state,
                    textInputType: TextInputType.text,
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return AppStrings.provideNewPasswordText;
                      } else if (v != newPasswordController.text) {
                        return AppStrings.passwordNotMatch;
                      } else {
                        return null;
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
