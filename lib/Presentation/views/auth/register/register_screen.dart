import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/common/loading_indicator.dart';
import 'package:grocery/Presentation/common/snack_bar_widget.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/assets.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/state%20management/bloc/set_bool_cubit.dart';
import 'package:grocery/Presentation/views/auth/common/bottom_container.dart';
import 'package:grocery/Presentation/views/auth/common/bottom_text.dart';
import 'package:grocery/Presentation/views/auth/register/bloc/registration_cubit.dart';

import '../../../../Data/errors/custom_error.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameContoller = TextEditingController();
  final emailController = TextEditingController();
  final passwordContoller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                      backButton(),
                      registerText(),
                      CustomSizedBox.height(25),
                      textFields(),
                      CustomSizedBox.height(30),
                      BlocListener<RegistrationCubit, RegistrationState>(
                        listener: (context, state) {
                          if (state.status == RegisterEnum.success) {
                            SnackBarWidget.buildSnackBar(
                              context,
                              AppStrings.registerSuccessfullyText,
                              AppColors.greenColor,
                              Icons.check,
                              true,
                            );
                            Navigator.of(context).pop();
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
                        child:
                            BlocBuilder<RegistrationCubit, RegistrationState>(
                          builder: (context, state) {
                            if (state.status == RegisterEnum.loading) {
                              return LoadingIndicator.loading();
                            }
                            return CustomButton(
                              text: AppStrings.registerText,
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  Map<String, dynamic> map = {
                                    "email": emailController.text,
                                    "first_name": firstNameController.text,
                                    "last_name": lastNameContoller.text,
                                    "password": passwordContoller.text,
                                  };
                                  await context
                                      .read<RegistrationCubit>()
                                      .registration(map);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      CustomSizedBox.height(20),
                      bottomText(
                        context,
                        "${AppStrings.alreadyRegisterText}?",
                        AppStrings.loginText,
                        () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                bottomContainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text registerText() {
    return Text(AppStrings.registerText,
        style: Styles.circularStdBook(
          AppSize.text34.sp,
          AppColors.blackColor,
        ));
  }

  Widget backButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 205.h,
        padding: const EdgeInsets.only(
          left: AppSize.p16,
          top: AppSize.p40,
        ).r,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.authBack1),
            fit: BoxFit.fill,
          ),
        ),
        child: const Align(
          alignment: Alignment.topLeft,
          child: Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
            size: 27,
          ),
        ),
      ),
    );
  }

  Widget textFields() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p15).r,
        child: Column(
          children: [
            CustomTextField(
              controller: firstNameController,
              labelText: AppStrings.firstNameText,
              hintText: AppStrings.enterFirstNameText,
              suffixIcon: const Text(""),
              obscureText: false,
              textInputType: TextInputType.text,
              validator: (v) {
                if (v!.trim().isEmpty) {
                  return AppStrings.provideFirstNameText;
                } else {
                  return null;
                }
              },
            ),
            CustomSizedBox.height(12),
            CustomTextField(
              controller: lastNameContoller,
              labelText: AppStrings.lastNameText,
              hintText: AppStrings.enterLastNameText,
              suffixIcon: const Text(""),
              obscureText: false,
              textInputType: TextInputType.text,
              validator: (v) {
                if (v!.trim().isEmpty) {
                  return AppStrings.provideLastNameText;
                } else {
                  return null;
                }
              },
            ),
            CustomSizedBox.height(12),
            CustomTextField(
              controller: emailController,
              labelText: AppStrings.emailText,
              hintText: AppStrings.enterEmailText,
              suffixIcon: const Text(""),
              obscureText: false,
              textInputType: TextInputType.text,
              validator: (v) {
                Pattern pattern =
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                RegExp regExp = RegExp(pattern.toString());
                if (v!.trim().isEmpty) {
                  return AppStrings.provideEmailText;
                } else if (!regExp.hasMatch(v)) {
                  return AppStrings.provideValidEmailText;
                } else {
                  return null;
                }
              },
            ),
            CustomSizedBox.height(12),
            BlocProvider(
              create: (context) => SetBoolCubit(false),
              child: BlocBuilder<SetBoolCubit, bool>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: passwordContoller,
                    labelText: AppStrings.passwordText,
                    hintText: AppStrings.enterPasswordText,
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
                        return AppStrings.providePasswordText;
                      } else if (v.length < 6) {
                        return AppStrings.passwordLengthText;
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
