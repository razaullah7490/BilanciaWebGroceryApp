import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/auth/common/screen_pattern.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
              ),
              CustomSizedBox.height(50),
              CustomButton(
                text: AppStrings.submitText,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushNamed(
                        context, RoutesNames.confirmationScreen);
                  }
                },
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
