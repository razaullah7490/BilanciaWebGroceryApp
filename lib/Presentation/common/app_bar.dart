import 'package:grocery/Application/exports.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    key,
    required this.title,
  })  : preferredSize = const Size.fromHeight(80),
        super(key: key);
  @override
  final Size preferredSize;

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.appBarColor,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: AppSize.appBarIconMar).r,
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.appBarIconShadowColor.withOpacity(0.15),
                  blurRadius: 5,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: AppSize.appBarIconPad).r,
                child: Icon(
                  Icons.navigate_before,
                  color: AppColors.primaryColor,
                  size: AppSize.appBarIconSize.r,
                ),
              ),
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: AppSize.appBarTextPad).r,
        child: Text(
          widget.title,
          style: Styles.circularStdMedium(
            AppSize.appBarTextSize.sp,
            AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
