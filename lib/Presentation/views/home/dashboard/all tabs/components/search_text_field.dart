import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';

import '../../../../../resources/assets.dart';
import '../../../../../resources/sized_box.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;

  const SearchTextField({
    super.key,
    required this.controller,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField>
    with SingleTickerProviderStateMixin {
  bool isChanged = false;
  Pattern pattern = "-1";

  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1 + _animationController!.value;
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: widget.controller,
            style: Styles.segoeUI(AppSize.text15.sp, AppColors.blackColor),
            onChanged: (v) {
              if (v.isNotEmpty) {
                setState(() {
                  isChanged = true;
                });
              }
            },
            decoration: InputDecoration(
              hintText: AppStrings.searchHereText,
              hintStyle: Styles.circularStdBook(
                  AppSize.text14.sp, AppColors.hintTextColor),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
                size: AppSize.icon28,
              ),
              suffixIcon: isChanged
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.controller.clear();
                          isChanged = false;
                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Icon(
                        Icons.close,
                        size: AppSize.clearSearchTextFieldIconSize.r,
                        color: AppColors.hintTextColor,
                      ),
                    )
                  : const Text(""),
              contentPadding:
                  const EdgeInsets.only(top: AppSize.p16, bottom: AppSize.p16)
                      .r,
              filled: true,
              fillColor: AppColors.searchTextFieldColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    AppBorderRadius.searchTextFieldRadius.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    AppBorderRadius.searchTextFieldRadius.r),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    AppBorderRadius.searchTextFieldRadius.r),
                borderSide: const BorderSide(color: AppColors.secondaryColor),
              ),
            ),
          ),
        ),
        CustomSizedBox.width(10),
        GestureDetector(
          onTap: () async {
            await scanBarcode();
          },
          onTapDown: onTapDown,
          onTapUp: onTapUp,
          onTapCancel: onTapCancel,
          behavior: HitTestBehavior.opaque,
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: 50.w,
              height: 47.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(
                    AppBorderRadius.barcodeContainerRadius.r),
              ),
              child: Center(
                child: Image.asset(
                  Assets.barcode,
                  width: 26.w,
                  height: 26.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future scanBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#52B467",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      scanResult = "Failed, Please try again!!!";
    }

    if (!mounted) return;
    if (scanResult.isNotEmpty) {
      setState(() {
        widget.controller.text = scanResult.contains(pattern) ? "" : scanResult;
      });
    }
  }

  onTapDown(TapDownDetails details) {
    _animationController!.forward();
  }

  onTapUp(TapUpDetails details) {
    _animationController!.reverse();
  }

  onTapCancel() {
    _animationController!.reverse();
  }
}
