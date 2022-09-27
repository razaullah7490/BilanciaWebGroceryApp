import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/assets.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';

class CustomBottomSheet extends StatefulWidget {
  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;

  const CustomBottomSheet({
    super.key,
    required this.onGalleryTap,
    required this.onCameraTap,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bottomSheet(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 85.w,
        height: 75.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.secondaryColor,
            width: 1.5.w,
          ),
          borderRadius: BorderRadius.circular(
            AppBorderRadius.chooseImageContainerRadius.r,
          ),
        ),
        child: Center(
          child: Image.asset(
            Assets.gallery,
            width: 45.w,
            height: 38.w,
          ),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius.r),
            topRight: Radius.circular(AppBorderRadius.bottomSheetRadius.r),
          ),
        ),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(AppBorderRadius.bottomSheetRadius.r),
                    topRight:
                        Radius.circular(AppBorderRadius.bottomSheetRadius.r),
                  ),
                ),
                child: Column(
                  children: [
                    CustomSizedBox.height(10),
                    bottomSheetListTile(
                      context,
                      Icons.image,
                      AppStrings.fromGalleryText,
                      widget.onGalleryTap,
                    ),
                    CustomSizedBox.height(10),
                    bottomSheetListTile(
                      context,
                      Icons.camera,
                      AppStrings.fromCameraText,
                      widget.onCameraTap,
                    ),
                    CustomSizedBox.height(10),
                  ],
                ),
              ),
            ],
          );
        });
  }

  ListTile bottomSheetListTile(
    BuildContext context,
    IconData iconData,
    String text,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: CircleAvatar(
        radius: AppBorderRadius.bottomSheetItemRadius.r,
        backgroundColor: AppColors.appBarColor,
        child: Icon(
          iconData,
          color: AppColors.primaryColor,
          size: AppSize.bottomSheetIconSize.r,
        ),
      ),
      title: Text(
        text,
        style: Styles.circularStdMedium(
          AppSize.text15.sp,
          AppColors.blackColor,
        ),
      ),
      onTap: onTap,
    );
  }
}
