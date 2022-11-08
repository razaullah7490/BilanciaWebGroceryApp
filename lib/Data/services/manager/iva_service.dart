// ignore_for_file: depend_on_referenced_packages, unused_local_variable
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

  Future<bool> addIva(ivaValue) async {
    var token = await AppPrefs.getLoginToken();
    Map<String, dynamic> map = {"value": ivaValue};
    try {
      var res = await http.post(
        Uri.parse(ApiUrls.ivaUrl),
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

  static Future<bool> editIva(id, ivaValue) async {
    var token = await AppPrefs.getLoginToken();
    Map<String, dynamic> map = {"value": ivaValue};
    String url = "${ApiUrls.ivaUrl}/$id/";
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
        throw httpErrorHandler(data['value'][0].toString());
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteIva(id) async {
    var token = await AppPrefs.getLoginToken();
    String url = "${ApiUrls.ivaUrl}/$id/";
    try {
      var res = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $token",
        },
      );
      if (res.statusCode != 204) {
        throw httpErrorHandler("no data");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
