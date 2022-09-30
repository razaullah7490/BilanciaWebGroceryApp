import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/size.dart';

import '../../../../../resources/app_strings.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/text_styles.dart';

class PopUpMenuWidget extends StatelessWidget {
  final ValueChanged onSelected;
  PopUpMenuWidget({
    super.key,
    required this.onSelected,
  });
  final GlobalKey<PopupMenuButtonState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _key.currentState!.showButtonMenu(),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 30.w,
        height: 30.h,
        child: PopupMenuButton(
          padding: EdgeInsets.zero,
          elevation: 5,
          key: _key,
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.primaryColor,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0).r,
              side: const BorderSide(
                width: 0.5,
                color: AppColors.textFieldFillColor,
              )),
          itemBuilder: (context) {
            return <PopupMenuEntry>[
              popUpMenuItem(
                context,
                AppStrings.editText,
                Icons.edit,
                AppColors.primaryColor,
              ),
              popUpMenuItem(
                context,
                AppStrings.deleteText,
                Icons.delete,
                AppColors.redColor2,
              ),
            ];
          },
          onSelected: onSelected,
        ),
      ),
    );
  }

  PopupMenuItem<dynamic> popUpMenuItem(
    BuildContext context,
    String text,
    IconData iconData,
    Color color,
  ) {
    return PopupMenuItem(
      height: 0,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3).r,
      value: text,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6).r,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.0).r,
        ),
        child: Row(
          children: [
            Icon(iconData, color: color, size: 20.r),
            SizedBox(width: 5.w),
            Text(text,
                style: Styles.circularStdBook(
                  AppSize.text10.sp,
                  AppColors.blackColor,
                )),
          ],
        ),
      ),
    );
  }
}
