// ignore_for_file: unused_local_variable, depend_on_referenced_packages
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:grocery/Domain/models/inventory/proceed_resource_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Data/errors/http_error_handler.dart';

class ProceedResourceService {
  // static Future<bool> addProceedResource(map) async {
  //   var dio = Dio();
  //   var token = await AppPrefs.getLoginToken();
  //   // var formData = FormData.fromMap(map);
  //   // var bytes = utf8.encode(json.encode(formData));
  //   try {
  //     var res = await dio.post(
  //       ApiUrls.proceedResourceUrl,
  //       data: map,
  //       options: Options(
  //         followRedirects: false,
  //         //contentType: 'application/json; charset=UTF-8',
  //         headers: {
  //           "Authorization": "Token $token",
  //           // 'Accept': 'application/json',
  //           // 'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //       ),
  //     );
  //     log("DIO ${res.statusCode}  ${res.data}");
  //     return true;
  //   } on DioError catch (e) {
  //     if (e.response!.statusCode != 201) {
  //       log("status code ${e.response!.statusCode}");
  //       log("1 ${e.response!.data}");
  //       log("Error ${e.response!.data['detail'].toString()}");
  //       throw httpErrorHandler(e.response!.data['detail'].toString());
  //     } else {
  //       return false;
  //     }
  //   }
  // }

  Future<bool> addProceedResource(Map<String, dynamic> map) async {
    var token = await AppPrefs.getLoginToken();
    var bytes = utf8.encode(json.encode(map));
    try {
      var res = await http.post(
        Uri.parse(ApiUrls.proceedResourceUrl),
        body: bytes,
        headers: {
          "Authorization": "Token $token",
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      var data = json.decode(res.body);
      log("Data ${res.statusCode} $data");
      if (res.statusCode != 201) {
        log("Data ${res.statusCode} ${res.body}");
        throw httpErrorHandler(data['detail'].toString());
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProceedResourcesModel>> getProceedResource() async {
    var token = await AppPrefs.getLoginToken();

    try {
      var res = await http.get(
        Uri.parse(ApiUrls.proceedResourceUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );
      var data = json.decode(res.body) as List<dynamic>;
      log("testing ${res.statusCode}");

      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }

      log("Data ${data.map((e) => ProceedResourcesModel.fromJson(e)).toList()}");
      return data.map((e) => ProceedResourcesModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> editProceedResource(id, map) async {
    var token = await AppPrefs.getLoginToken();
    var bytes = utf8.encode(json.encode(map));
    var url = "${ApiUrls.proceedResourceUrl}/$id/";
    try {
      var res = await http.put(
        Uri.parse(url),
        body: bytes,
        headers: {
          "Authorization": "Token $token",
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      var data = json.decode(res.body);
      log("Data ${res.statusCode} $data");
      if (res.statusCode != 200) {
        log("Data ${res.statusCode} ${res.body}");
        throw httpErrorHandler(data['detail'].toString());
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteProceedResource(id) async {
    var token = await AppPrefs.getLoginToken();
    var url = "${ApiUrls.proceedResourceUrl}/$id/";
    try {
      var res = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode} ${res.body}");
      if (res.statusCode != 204) {
        throw httpErrorHandler("no data");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
