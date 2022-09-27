import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/common/snack_bar_widget.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';

import '../../../../../../common/app_bar.dart';
import '../../../../../../resources/size.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.editProfileText,
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
              CustomButton(
                text: AppStrings.updateText,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.profileUpdatedSuccessText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                  }
                },
              ),
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
          CustomSizedBox.height(20),
          CustomTextField(
            controller: lastNameController,
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
          CustomSizedBox.height(20),
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
        ],
      ),
    );
  }
}
