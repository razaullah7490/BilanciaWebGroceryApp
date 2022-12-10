import 'package:grocery/Application/exports.dart';

class WebPortalScreen extends StatelessWidget {
  const WebPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 5,
      ),
      body:  Center(
        child: Text(
          AppStrings.routeErrorMessage,
          style: Styles.segoeUI(AppSize.text18.sp, AppColors.blackColor,),
        ),
      ),
    );
  }
}
