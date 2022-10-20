// ignore_for_file: depend_on_referenced_packages, unused_local_variable
import 'dart:convert';
import 'dart:developer';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Data/errors/http_error_handler.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordService {
  Future<bool> passwordReset(String email) async {
    try {
      var res = await http.post(
        Uri.parse(ApiUrls.requestPasswordResetUrl),
        body: {
          "email": email,
        },
      );
      log("testing ${res.statusCode}");
      log("Error ${res.reasonPhrase}");
      var data = json.decode(res.body);
      //log("Data ${res.body}");
      if (res.statusCode != 201) {
        // var data = json.decode(res.body);
        log("Email ${data["email"][0].toString()}");
        log("Error ${res.reasonPhrase}");
        throw httpErrorHandler(data["email"][0].toString());
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> passwordResetConfirm(map, url) async {
    try {
      var res = await http.put(
        Uri.parse(url),
        body: map,
      );
      log("testing ${res.statusCode}");
      var data = json.decode(res.body);
      if (res.statusCode != 200) {
        log("Error ${data["error"].toString()}");
        throw httpErrorHandler(data["error"].toString());
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
