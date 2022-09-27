import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBarWidget {
  static buildSnackBar(
    BuildContext context,
    String message,
    Color color,
    IconData icon,
    bool isFloating,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Wrap(
        direction: Axis.horizontal,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 22.r,
          ),
          Text(message),
        ],
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 1),
      behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
    ));
  }
}
