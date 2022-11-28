import 'package:grocery/Application/exports.dart';

class SearchBarcodeWidget extends StatelessWidget {
  final VoidCallback onTap;
  const SearchBarcodeWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 50.w,
        height: 47.w,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius:
              BorderRadius.circular(AppBorderRadius.barcodeContainerRadius.r),
        ),
        child: Center(
          child: Image.asset(
            Assets.barcode,
            width: 26.w,
            height: 26.w,
          ),
        ),
      ),
    );
  }
}
