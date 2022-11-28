import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:grocery/Application/exports.dart';

class LogoutService {
  Future<bool> logout() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.post(
        Uri.parse(ApiUrls.logoutUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log('Logout response : ${res.statusCode}');
      if (res.statusCode != 204) {
        throw httpErrorHandler("no data");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
