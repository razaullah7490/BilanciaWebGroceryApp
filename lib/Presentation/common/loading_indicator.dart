import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
