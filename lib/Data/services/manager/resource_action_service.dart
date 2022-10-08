// ignore_for_file: depend_on_referenced_packages, unused_local_variable
import 'dart:convert';
import 'dart:developer';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Domain/models/inventory/resource_action_model.dart';
import 'package:http/http.dart' as http;
import '../../errors/http_error_handler.dart';

class ResourceActionService {
  Future<bool> addResourceAction(map) async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.post(
        Uri.parse(ApiUrls.resourcesActionUrl),
        body: map,
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      var data = json.decode(res.body);
      if (res.statusCode != 201) {
        throw httpErrorHandler(data['detail'].toString());
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ResourceActionModel>> getResoruceAction() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.resourcesActionUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      var data = json.decode(res.body) as List<dynamic>;
      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }
      log("data ${res.body}");
      log("Data ${data.map((e) => ResourceActionModel.fromMap(e)).toList()}");
      return data.map((e) => ResourceActionModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteResourceAction(id) async {
    var token = await AppPrefs.getLoginToken();
    var url = "${ApiUrls.resourcesActionUrl}/$id/";
    try {
      var res = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $token",
        },
      );
      // var data = json.decode(res.body);
      log("testing ${res.statusCode}");
      if (res.statusCode != 204) {
        throw httpErrorHandler("not deleted");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
