import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/assets.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/auth/common/screen_pattern.dart';
import 'package:grocery/Presentation/views/auth/login/login_screen.dart';

class SuccessfullyRecoveredPasswordScreen extends StatefulWidget {
  const SuccessfullyRecoveredPasswordScreen({super.key});

  @override
  State<SuccessfullyRecoveredPasswordScreen> createState() =>
      _SuccessfullyRecoveredPasswordScreenState();
}

class _SuccessfullyRecoveredPasswordScreenState
    extends State<SuccessfullyRecoveredPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: Column(
        children: [
          CustomSizedBox.height(50),
          image(),
          CustomSizedBox.height(40),
          titleText(),
          CustomSizedBox.height(5),
          descriptionText(),
          CustomSizedBox.height(30),
          CustomButton(
            text: AppStrings.loginText,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }

  Image image() {
    return Image.asset(
      Assets.successfullyRecovered,
      width: double.infinity,
      height: 95.h,
    );
  }

  Text titleText() {
    return Text(
      AppStrings.successfullyRecoveredText,
      textAlign: TextAlign.center,
      style: Styles.circularStdBook(
        32.sp,
        AppColors.blackColor,
      ),
    );
  }

  Widget descriptionText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        AppStrings.loginToYourAccountText,
        textAlign: TextAlign.center,
        style: Styles.segoeUI(
          14.sp,
          AppColors.blackColor,
        ),
      ),
    );
  }
}
