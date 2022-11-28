// ignore_for_file: unused_local_variable, depend_on_referenced_packages
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:grocery/Application/exports.dart';

class CatergoryService {
  Future<bool> addCategory(map) async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.post(
        Uri.parse(ApiUrls.categoryUrl),
        body: map,
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("Response ${res.body}");
      var data = json.decode(res.body);
      log("testing ${res.statusCode}");

      if (res.statusCode != 201) {
        throw httpErrorHandler("no data");
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> getCategory() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.categoryUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );
      var data = json.decode(res.body) as List<dynamic>;
      log("testing ${res.statusCode}");

      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }
      log("Data ${data.map((e) => CategoryModel.fromMap(e)).toList()}");
      return data.map((e) => CategoryModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> editCategory(id, map) async {
    var token = await AppPrefs.getLoginToken();
    String url = "${ApiUrls.categoryUrl}/$id/";
    try {
      var res = await http.put(
        Uri.parse(url),
        body: map,
        headers: {
          "Authorization": "Token $token",
        },
      );
      var data = json.decode(res.body);
      log("testing ${res.statusCode}");
      if (res.statusCode != 200) {
        throw httpErrorHandler("no data");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteCategory(id) async {
    var token = await AppPrefs.getLoginToken();
    String url = "${ApiUrls.categoryUrl}/$id/";
    try {
      var res = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $token",
        },
      );
      var data = json.decode(res.body);
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
