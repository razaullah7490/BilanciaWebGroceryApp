import 'dart:convert';
import 'dart:developer';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Data/errors/http_error_handler.dart';
import 'package:grocery/Domain/models/manager/iva_model.dart';
import 'package:http/http.dart' as http;

class IvaService {
  Future<List<IvaModel>> getIva() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.ivaUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );

      var data = json.decode(res.body) as List<dynamic>;
      log("testing ${res.statusCode}");

      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }

      return data.map((e) => IvaModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
