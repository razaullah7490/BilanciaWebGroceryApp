// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/Prefs/prefs_keys.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/auth/login/login_screen.dart';
import 'package:grocery/Presentation/views/home/dashboard/components/dashboard_app_bar.dart';
import 'package:grocery/Presentation/views/home/dashboard/components/dashboard_grid_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../resources/routes/navigation.dart';
import '../../auth/login/bloc/login_cubit.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  Future checkTokenAndLogin() async {
    var pref = await SharedPreferences.getInstance();
    var email = await AppPrefs.getUserEmail();
    var password = await AppPrefs.getUserPassword();

    if (email.isNotEmpty || password.isNotEmpty) {
      Map<String, dynamic> map = {
        "username": email,
        "password": password,
      };
      var isValid = await context.read<LoginCubit>().loginAgain(map);
      if (isValid == false) {
        await pref.remove(AppPrefsKeys.loginKey);
        Navigate.toReplace(context, const LoginScreen());
        // Navigator.pushReplacementNamed(context, RoutesNames.loginScreen);
      }
    }
  }

  @override
  void initState() {
    checkTokenAndLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashBoardLargeAppBar(),
            CustomSizedBox.height(15),
            titleText(),
            CustomSizedBox.height(15),
            const DashBoardGridTile(),
          ],
        ),
      ),
    );
  }

  Widget titleText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.p10).r,
      child: Text(
        AppStrings.dashboardText,
        style: Styles.circularStdBook(
          AppSize.text25.sp,
          AppColors.blackColor,
        ),
      ),
    );
  }
}
