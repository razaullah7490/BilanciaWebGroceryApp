import 'package:grocery/Application/exports.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;
  const LogoutButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p15,
          vertical: AppSize.p15,
        ).r,
        margin: const EdgeInsets.symmetric(vertical: AppSize.m10).r,
        decoration: BoxDecoration(
          color: AppColors.addProductContainerColor,
          borderRadius: BorderRadius.circular(
              AppBorderRadius.notificationchildContainerRadius.r),
          border: Border.all(color: AppColors.logoutborderColor, width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: AppColors.logoutborderColor,
                borderRadius: BorderRadius.circular(
                    AppBorderRadius.appBarContainerBorderRadius.r),
              ),
              child: Center(
                  child: Image.asset(
                Assets.logout,
                width: 24.w,
                height: 24.w,
              )),
            ),
            CustomSizedBox.width(20),
            Text(
              AppStrings.logOutText,
              style: Styles.circularStdBook(
                AppSize.text17.sp,
                AppColors.containerTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
