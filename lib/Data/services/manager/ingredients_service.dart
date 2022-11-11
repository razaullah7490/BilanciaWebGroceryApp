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

  Future<bool> addIngredient(String description) async {
    var token = await AppPrefs.getLoginToken();
    Map<String, dynamic> map = {"description": description};
    try {
      var res = await http.post(
        Uri.parse(ApiUrls.ingredientsUrl),
        body: map,
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      log("Body ${res.body}");
      if (res.statusCode != 201) {
        throw httpErrorHandler("An Error Occured, Please try again!");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> editIngredient(int id, String description) async {
    var token = await AppPrefs.getLoginToken();
    Map<String, dynamic> map = {"description": description};
    String url = "${ApiUrls.ingredientsUrl}/$id/";
    try {
      var res = await http.put(
        Uri.parse(url),
        body: map,
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      log("Body ${res.body}");
      var data = json.decode(res.body);
      if (res.statusCode != 200) {
        return false;
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteIngredient(int id) async {
    var token = await AppPrefs.getLoginToken();
    String url = "${ApiUrls.ingredientsUrl}/$id/";
    try {
      var res = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      if (res.statusCode != 204) {
        throw httpErrorHandler("no data");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
