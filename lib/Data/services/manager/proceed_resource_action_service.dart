// ignore_for_file: unused_local_variable, depend_on_referenced_packages
import 'dart:convert';
import 'dart:developer';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Data/errors/http_error_handler.dart';
import 'package:grocery/Domain/models/inventory/proceed_resource_action_model.dart';
import 'package:http/http.dart' as http;

class ProceedResourceActionService {
  Future<bool> addProceedResourceAction(map) async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.post(
        Uri.parse(ApiUrls.proceedResourceActionUrl),
        body: map,
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      log("data ${res.body}");
      var data = json.decode(res.body);
      if (res.statusCode != 201) {
        throw httpErrorHandler(data['detail'].toString());
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProcessedResourceActionModel>> getProceedResourceAction() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.proceedResourceActionUrl),
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
      log("Data ${data.map((e) => ProcessedResourceActionModel.fromMap(e)).toList()}");
      return data.map((e) => ProcessedResourceActionModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteProceedResourceAction(id) async {
    var token = await AppPrefs.getLoginToken();
    var url = "${ApiUrls.proceedResourceActionUrl}/$id/";
    try {
      var res = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      if (res.statusCode != 204) {
        throw httpErrorHandler("Action Not Deleted");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
