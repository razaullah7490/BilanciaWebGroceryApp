import 'package:grocery/Application/exports.dart';

commaReplaceToDot(TextEditingController controller, value) {
  var data = value.replaceAll(",", ".");
  controller.text = data;
}
