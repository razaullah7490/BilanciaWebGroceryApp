// ignore_for_file: depend_on_referenced_packages, unused_local_variable
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:grocery/Application/exports.dart';

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

  Future<ResourceActionModel> getResoruceAction(pageNumber) async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse("${ApiUrls.resourcesActionUrl}?page=$pageNumber"),
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
