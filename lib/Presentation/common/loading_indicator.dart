import 'package:grocery/Application/exports.dart';

class LoadingIndicator {
  static Widget loadingExpanded() {
    return Expanded(
      child: Center(
        child: LoadingAnimationWidget.inkDrop(
          color: AppColors.secondaryColor,
          size: 30.r,
        ),
      ),
    );
  }

  static Widget loading() {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: AppColors.secondaryColor,
        size: 30.r,
      ),
    );
  }

  static Widget smallLoading() {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: AppColors.secondaryColor,
        size: 25.r,
      ),
    );
  }
}
