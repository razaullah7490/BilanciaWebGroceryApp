// ignore_for_file: unused_local_variable, depend_on_referenced_packages
import 'package:grocery/Domain/models/manager/tag_model.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Data/errors/http_error_handler.dart';
import 'package:http/http.dart' as http;

class TagService {
  Future<List<TagModel>> getAllTags() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.tagUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      var data = json.decode(res.body) as List<dynamic>;
      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }
      log("Data ${data.map((e) => TagModel.fromMap(e)).toList()}");
      return data.map((e) => TagModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addTag(map) async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.post(
        Uri.parse(ApiUrls.tagUrl),
        body: map,
        headers: {
          "Authorization": "Token $token",
        },
      );
      var data = json.decode(res.body);
      log("testing ${res.statusCode}");
      if (res.statusCode != 201) {
        throw httpErrorHandler("An error occured, Please try again!!!");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> editTag(id, map) async {
    var token = await AppPrefs.getLoginToken();
    String url = "${ApiUrls.tagUrl}/$id/";
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

  Future<bool> deleteTag(id) async {
    var token = await AppPrefs.getLoginToken();
    String url = "${ApiUrls.tagUrl}/$id/";
    try {
      var res = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $token",
        },
      );
      if (res.statusCode != 204) {
        throw httpErrorHandler("not found");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
