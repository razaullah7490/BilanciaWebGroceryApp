import 'dart:convert';
import 'dart:developer';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Data/errors/http_error_handler.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<bool> login(Map map) async {
    try {
      var res = await http.post(Uri.parse(ApiUrls.loginUrl), body: map);
      var data = json.decode(res.body);
      log("testing ${res.statusCode}");
      if (res.statusCode == 200) {
        log("Login Token : ${data["token"].toString()}");
        log("User $data");
        await AppPrefs.setLoginToken(data['token'].toString());
        await AppPrefs.setUserId(data['user']['id'].toString());
        await AppPrefs.setUserEmail(data['user']['email'].toString());
        await AppPrefs.setUserFirstName(data['user']['first_name'].toString());
        await AppPrefs.setUserLastName(data['user']['last_name'].toString());
        return true;
      }
      throw httpErrorHandler(data['non_field_errors'][0]);
    } catch (e) {
      rethrow;
    }
  }
}
