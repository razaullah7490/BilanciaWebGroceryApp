// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Data/errors/http_error_handler.dart';
import 'package:grocery/Domain/models/manager/ingredient_model.dart';
import 'package:http/http.dart' as http;

class IngredientService {
  Future<List<IngredientModel>> getIngredients() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.ingredientsUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );
      var data = json.decode(res.body) as List<dynamic>;
      log("testing ${res.statusCode}");
      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }
      log("Data ${data.map((e) => IngredientModel.fromMap(e)).toList()}");
      return data.map((e) => IngredientModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
