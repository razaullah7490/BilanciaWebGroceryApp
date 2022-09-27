import 'dart:convert';
import 'dart:developer';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Data/errors/http_error_handler.dart';
import 'package:http/http.dart' as http;

class RegisterationService {
  Future<bool> register(Map map) async {
    try {
      var res = await http.post(Uri.parse(ApiUrls.registerUrl), body: map);
      var data = json.decode(res.body);
      log("testing ${res.statusCode}");
      if (res.statusCode != 200) {
        throw httpErrorHandler(data['email'][0]);
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
