import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/assets.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/state%20management/bloc/set_bool_cubit.dart';
import 'package:grocery/Presentation/views/auth/common/bottom_container.dart';
import 'package:grocery/Presentation/views/auth/common/bottom_text.dart';

import '../../../../Data/errors/custom_error.dart';
import '../../../common/loading_indicator.dart';
import '../../../common/snack_bar_widget.dart';
import 'bloc/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      imageAndName(),
                      CustomSizedBox.height(40),
                      textFields(),
                      CustomSizedBox.height(40),
                      BlocListener<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state.status == LoginEnum.success) {
                            SnackBarWidget.buildSnackBar(
                              context,
                              AppStrings.loginSuccessfullyText,
                              AppColors.greenColor,
                              Icons.check,
                              true,
                            );
                            Navigator.pushReplacementNamed(
                                context, RoutesNames.dashboardScreen);
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
                        child: BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                          if (state.status == LoginEnum.loading) {
                            return LoadingIndicator.loading();
                          }

                          return CustomButton(
                            text: AppStrings.loginText,
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                Map<String, dynamic> map = {
                                  "username": emailController.text,
                                  "password": passwordContoller.text,
                                };
                                await context.read<LoginCubit>().login(map);
                              }
                            },
                          );
                        }),
                      ),
                      CustomSizedBox.height(30),
                      bottomText(
                          context,
                          AppStrings.createNewAccountText,
                          AppStrings.signUpText,
                          () => Navigator.pushNamed(
                                context,
                                RoutesNames.registerScreen,
                              )),
                    ],
                  ),
                ),
                bottomContainer(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget imageAndName() {
    return Column(
      children: [
        Image.asset(Assets.authBack1),
        Text(AppStrings.loginText,
            style: Styles.circularStdBook(
              AppSize.text34.sp,
              AppColors.blackColor,
            )),
      ],
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
              controller: emailController,
              labelText: AppStrings.emailText,
              hintText: AppStrings.enterEmailText,
              suffixIcon: const Text(""),
              obscureText: false,
              textInputType: TextInputType.emailAddress,
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
            CustomSizedBox.height(20),
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
                      } else {
                        return null;
                      }
                    },
                  );
                },
              ),
            ),
            CustomSizedBox.height(15),
            forgetPassword(),
          ],
        ),
      ),
    );
  }

  Widget forgetPassword() {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>
            Navigator.pushNamed(context, RoutesNames.forgetPasswordScreen),
        child: Text(
          "${AppStrings.forgetPasswordText}?",
          style:
              Styles.circularStdBook(AppSize.text13.sp, AppColors.blackColor),
        ),
      ),
    );
  }
}
