import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker {
  static Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    return imageTemporary;
  }
}
