import 'package:grocery/Application/exports.dart';

class Navigate {
  Navigate._();

  static to(BuildContext context, Widget child) {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.topToBottom, child: child));
  }

  static toReplace(BuildContext context, Widget child) {
    Navigator.pushReplacement(context,
        PageTransition(type: PageTransitionType.topToBottom, child: child));
  }
}
