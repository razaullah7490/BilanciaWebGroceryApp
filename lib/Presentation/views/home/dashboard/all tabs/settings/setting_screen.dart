// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Application/Prefs/prefs_keys.dart';
import 'package:grocery/Data/services/auth/logout_service.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/components/logout_button.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/components/setting_components_container.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/logout%20bloc/logout_cubit.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/setting_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common/loading_indicator.dart';
import '../../../../../common/snack_bar_widget.dart';
import '../../../../../resources/colors_palette.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.settingText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p12).r,
        child: Column(
          children: [
            CustomSizedBox.height(20),
            Expanded(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: SettingViewModel.settingList.length,
                      itemBuilder: (context, index) {
                        var singleData = SettingViewModel.settingList[index];
                        return SettingComponentsContainer(model: singleData);
                      }),
                  BlocListener<LogoutCubit, LogoutState>(
                    listener: (context, state) {
                      if (state.status == LogoutEnum.success) {
                        SnackBarWidget.buildSnackBar(
                          context,
                          AppStrings.logoutText,
                          AppColors.greenColor,
                          Icons.check,
                          true,
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          RoutesNames.loginScreen,
                          (Route<dynamic> route) => false,
                        );
                      }

                      if (state.status == LogoutEnum.error) {
                        SnackBarWidget.buildSnackBar(
                          context,
                          AppStrings.errorOccuredText,
                          AppColors.redColor,
                          Icons.close,
                          true,
                        );
                      }
                    },
                    child: BlocBuilder<LogoutCubit, LogoutState>(
                      builder: (context, state) {
                        if (state.status == LogoutEnum.loading) {
                          return SizedBox(
                              height: 80.h, child: LoadingIndicator.loading());
                        }
                        return LogoutButton(
                          onTap: () async {
                            var isValid =
                                await context.read<LogoutCubit>().logout();
                            if (isValid == true) {
                              var pref = await SharedPreferences.getInstance();
                              await pref.remove(AppPrefsKeys.loginKey);
                              await pref.remove(AppPrefsKeys.registerKey);
                              await pref.remove(AppPrefsKeys.userEmail);
                              await pref.remove(AppPrefsKeys.userFirstName);
                              await pref.remove(AppPrefsKeys.userLastName);
                              await pref.remove(AppPrefsKeys.userId);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
