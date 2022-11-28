// ignore_for_file: depend_on_referenced_packages, unused_local_variable
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:grocery/Application/exports.dart';

class ChangePasswordService {
  Future<bool> changePassword(map) async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.put(
        Uri.parse(ApiUrls.changePasswordUrl),
        body: map,
        headers: {
          "Authorization": "Token $token",
        },
      );
      var data = json.decode(res.body);
      log("testing ${res.statusCode}");
      log("Data ${res.body}");
      if (res.statusCode != 200) {
        throw httpErrorHandler(data["old_password"][0].toString());
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
