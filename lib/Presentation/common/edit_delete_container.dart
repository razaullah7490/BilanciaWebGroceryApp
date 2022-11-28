import 'package:grocery/Application/exports.dart';

Widget editDeleteIcons({
  required VoidCallback onTapEdit,
  required VoidCallback onTapDelete,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: AppSize.p15, vertical: 7).r,
    decoration: BoxDecoration(
      color: AppColors.editDeleteFillColor,
      border: Border.all(
        color: AppColors.editDeleteBorderColor,
      ),
      borderRadius: BorderRadius.circular(25.r),
    ),
    child: Row(
      children: [
        GestureDetector(
          onTap: onTapEdit,
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.edit,
            color: AppColors.primaryColor,
            size: AppSize.editDeleteIconSize.r,
          ),
        ),
        CustomSizedBox.width(12),
        GestureDetector(
          onTap: onTapDelete,
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.delete,
            color: Colors.red.shade400,
            size: AppSize.editDeleteIconSize.r,
          ),
        ),
      ],
    ),
  );
}
