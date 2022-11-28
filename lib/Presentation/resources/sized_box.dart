import 'package:grocery/Application/exports.dart';

class CustomSizedBox {
  static SizedBox height(double height) {
    return SizedBox(height: height.h);
  }

  static SizedBox width(double width) {
    return SizedBox(width: width.w);
  }
}
