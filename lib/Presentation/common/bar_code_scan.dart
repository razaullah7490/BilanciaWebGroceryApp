// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:grocery/Presentation/resources/border_radius.dart';
// import 'package:grocery/Presentation/resources/colors_palette.dart';
// import '../resources/assets.dart';
// import '../resources/size.dart';
// class BarcodeScanWidget extends StatefulWidget {
//   final TextEditingController barCodeController;
//   const BarcodeScanWidget({
//     super.key,
//     required this.barCodeController,
//   });
//   @override
//   State<BarcodeScanWidget> createState() => _BarcodeScanWidgetState();
// }
// class _BarcodeScanWidgetState extends State<BarcodeScanWidget> {
//   Pattern pattern = "-1";
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         await scanBarcode();
//       },
//       behavior: HitTestBehavior.opaque,
//       child: Container(
//         margin: const EdgeInsets.all(AppSize.m4).r,
//         padding: const EdgeInsets.symmetric(
//                 vertical: AppSize.p9, horizontal: AppSize.p8)
//             .r,
//         decoration: BoxDecoration(
//           color: AppColors.primaryColor,
//           borderRadius:
//               BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
//         ),
//         child: Image.asset(
//           Assets.barcode,
//           width: 10.w,
//           height: 10.w,
//         ),
//       ),
//     );
//   }
//   Future scanBarcode() async {
//     String scanResult;
//     try {
//       scanResult = await FlutterBarcodeScanner.scanBarcode(
//         "#52B467",
//         "Cancel",
//         true,
//         ScanMode.BARCODE,
//       );
//     } on PlatformException {
//       scanResult = "Failed, Please try again!!!";
//     }
//     if (!mounted) return;
//     if (scanResult.isNotEmpty) {
//       setState(() {
//         widget.barCodeController.text =
//             scanResult.contains(pattern) ? "" : scanResult;
//       });
//     }
//   }
// }

import 'package:grocery/Application/exports.dart';

class BarcodeScanWidget extends StatelessWidget {
  final VoidCallback onTap;
  const BarcodeScanWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.all(AppSize.m4).r,
        padding: const EdgeInsets.symmetric(
                vertical: AppSize.p9, horizontal: AppSize.p8)
            .r,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius:
              BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
        ),
        child: Image.asset(
          Assets.barcode,
          width: 10.w,
          height: 10.w,
        ),
      ),
    );
  }
}
