// ignore_for_file: unused_local_variable, depend_on_referenced_packages
import 'dart:convert';
import 'dart:developer';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Data/errors/http_error_handler.dart';
import 'package:grocery/Domain/models/production_park_model.dart';
import 'package:http/http.dart' as http;

class ProductionParkService {
  Future<List<ProductionParkModel>> getProductionPark(id) async {
    var token = await AppPrefs.getLoginToken();
    String url = "${ApiUrls.productionParkUrl}/$id/";
    try {
      var res = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $token",
        },
      );
      var data = json.decode(res.body) as List<dynamic>;
      log("testing ${res.statusCode}");
      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }

      log("Data ${data.map((e) => ProductionParkModel.fromMap(e)).toList()}");
      return data.map((e) => ProductionParkModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addProductionPark(Map<String, dynamic> map) async {
    var token = await AppPrefs.getLoginToken();
    var bytes = utf8.encode(json.encode(map));
    try {
      var res = await http.post(
        Uri.parse(ApiUrls.productionParkUrl),
        body: bytes,
        headers: {
          "Authorization": "Token $token",
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      log("Response ${res.statusCode} Body ${res.body}");
      if (res.statusCode != 201) {
        throw httpErrorHandler("Something went wrong, Please try again!");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
