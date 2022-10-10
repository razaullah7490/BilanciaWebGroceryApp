// ignore_for_file: depend_on_referenced_packages, unused_local_variable
import 'dart:convert';
import 'dart:developer';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Data/errors/http_error_handler.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordService {
  Future<bool> passwordReset(email) async {
    var token = await AppPrefs.getLoginToken();
    Map<String, dynamic> body = {"email": email};

    try {
      var res = await http.post(
        Uri.parse(ApiUrls.requestPasswordResetUrl),
        body: body,
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      log("Data ${res.body}");
      if (res.statusCode != 201) {
        var data = json.decode(res.body);
        throw httpErrorHandler(data["email"][0].toString());
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
