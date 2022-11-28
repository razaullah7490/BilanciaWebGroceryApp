import 'package:grocery/Application/exports.dart';

class ScreenPattern extends StatelessWidget {
  final Widget child;
  const ScreenPattern({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: MediaQueryValues(context).width,
            height: MediaQueryValues(context).height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.whiteColor,
                      size: 27,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 280.w,
                    height: 440.h,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.backContainerBorderRadius,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 330.w,
                    height: 420.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.backContainerBorderRadius,
                      ),
                    ),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
