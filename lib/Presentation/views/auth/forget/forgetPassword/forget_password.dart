import 'dart:developer';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/navigation.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/auth/common/screen_pattern.dart';
import 'package:grocery/Presentation/views/auth/forget/setNewPassword/set_new_password.dart';
import '../../../../../Data/errors/custom_error.dart';
import '../../../../common/loading_indicator.dart';
import '../../../../common/snack_bar_widget.dart';
import '../Bloc/forget_password_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  initDynamicLink() async {
    dynamicLinks.onLink.listen((event) {
      try {
        log("Initial Link ${event.link}");
        Navigate.toReplace(context, SetNewPasswordScreen(initialLink: event));
      } catch (e) {
        log("eeeeee $e");
      }
    }).onError((e) {
      log("login screen Error $e");
    });
  }

  @override
  void initState() {
    initDynamicLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomSizedBox.height(50),
              titleText(),
              CustomSizedBox.height(5),
              descriptionText(
                  AppStrings.enterYourRegisterEmailText1, AppSize.text14.sp),
              descriptionText(
                  AppStrings.enterYourRegisterEmailText2, AppSize.text14.sp),
              CustomSizedBox.height(80),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.p22,
                ),
                child: CustomTextField(
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
              ),
              CustomSizedBox.height(50),
              BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
                listener: (context, state) {
                  if (state.status == ForgetPasswordEnum.success) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.emailVerifiedText,
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
                child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (context, state) {
                    if (state.status == ForgetPasswordEnum.loading) {
                      return LoadingIndicator.loading();
                    }
                    return CustomButton(
                      text: AppStrings.submitText,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await context
                              .read<ForgetPasswordCubit>()
                              .passwordReset(emailController.text.toString());
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text titleText() {
    return Text(
      "${AppStrings.forgetPasswordText}?",
      textAlign: TextAlign.center,
      style: Styles.circularStdMedium(
        AppSize.text30.sp,
        AppColors.blackColor,
        letterSpacing: 1,
      ),
    );
  }

  Text descriptionText(String text, double size) {
    return Text(
      text,
      style: Styles.segoeUI(
        size,
        AppColors.blackColor,
      ),
    );
  }
}
