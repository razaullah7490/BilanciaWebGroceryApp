import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:grocery/Application/exports.dart';

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
