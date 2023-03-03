// ignore_for_file: unused_local_variable, depend_on_referenced_packages
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:grocery/Application/exports.dart';

class ExportService {
  Future<bool> export() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.exportUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("Export Res ${res.statusCode} , ${res.body}");
      if (res.statusCode != 200) {
        throw httpErrorHandler("No Export");
      }
      return true;
    } catch (e) {
      return false;
      rethrow;
    }
  }
}
