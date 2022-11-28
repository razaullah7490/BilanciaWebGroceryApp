// ignore_for_file: unused_local_variable, depend_on_referenced_packages
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:grocery/Application/exports.dart';

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
      await AppPrefs.setProcessedResourceId(data['id'].toString());
      if (res.statusCode != 201) {
        throw httpErrorHandler(data['detail'].toString());
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResourceActionModel> getProceedResourceAction(pageNumber) async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse("${ApiUrls.proceedResourceActionUrl}?page=$pageNumber"),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      var data = json.decode(res.body);
      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }
      log("data ${res.body}");
      log("Data ${ResourceActionModel.fromJson(data)}");
      return ResourceActionModel.fromJson(data);
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
