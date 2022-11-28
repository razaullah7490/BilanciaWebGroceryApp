import 'package:grocery/Application/exports.dart';

class SettingComponentsContainer extends StatelessWidget {
  final SettingGridModel model;
  const SettingComponentsContainer({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigate.to(context, model.onTap),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p15,
          vertical: AppSize.p15,
        ).r,
        margin: const EdgeInsets.symmetric(vertical: AppSize.m10).r,
        decoration: BoxDecoration(
          color: model.backgroundColor,
          borderRadius: BorderRadius.circular(
              AppBorderRadius.notificationchildContainerRadius.r),
          border: Border.all(color: model.borderColor, width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: model.iconColor,
                borderRadius: BorderRadius.circular(
                    AppBorderRadius.appBarContainerBorderRadius.r),
              ),
              child: Center(
                  child: Image.asset(
                model.imageUrl,
                width: model.name == AppStrings.commandText ? 30.w : 24.w,
                height: model.name == AppStrings.commandText ? 30.w : 24.w,
              )),
            ),
            CustomSizedBox.width(20),
            Text(
              model.name,
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
