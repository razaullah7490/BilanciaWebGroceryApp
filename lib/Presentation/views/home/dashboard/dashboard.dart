// ignore_for_file: use_build_context_synchronously
import 'package:grocery/Application/exports.dart';

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
