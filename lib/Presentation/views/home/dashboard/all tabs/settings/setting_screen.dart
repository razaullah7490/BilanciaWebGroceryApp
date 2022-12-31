// ignore_for_file: use_build_context_synchronously
import 'package:grocery/Application/exports.dart';

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
              flex: 0,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: SettingViewModel.settingList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    var singleData = SettingViewModel.settingList[index];
                    return SettingComponentsContainer(model: singleData);
                  }),
            ),
            Flexible(
              child: BlocListener<LogoutCubit, LogoutState>(
                listener: (context, state) {
                  if (state.status == LogoutEnum.success) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.logoutText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false);
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
            ),
          ],
        ),
      ),
    );
  }
}
