import 'package:flutter/cupertino.dart';

class Styles {
  static TextStyle circularStdBook(double fontSize, Color color,
      {double letterSpacing = 0.0, double customH = 1}) {
    return TextStyle(
      height: customH,
      fontSize: fontSize,
      color: color,
      fontFamily: "Circular Std Book",
    );
  }

  static TextStyle circularStdMedium(double fontSize, Color color,
      {double letterSpacing = 0.0}) {
    return TextStyle(
      letterSpacing: letterSpacing,
      fontSize: fontSize,
      color: color,
      fontFamily: "Circular Std Medium",
    );
  }

  static TextStyle segoeUI(double fontSize, Color color) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontFamily: "Segoe UI",
    );
  }
}
