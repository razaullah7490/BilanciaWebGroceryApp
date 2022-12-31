// ignore_for_file: depend_on_referenced_packages, unused_local_variable
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:grocery/Application/exports.dart';

class ResourcesService {
  Future<bool> addResource(map) async {
    var dio = Dio();
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await dio.post(
        ApiUrls.resourcesUrl,
        data: map,
        options: Options(
          followRedirects: false,
          contentType: 'multipart/form-data',
          headers: {
            "Authorization": "Token $token",
            'Accept': 'application/json'
          },
        ),
      );

      return true;
    } on DioError catch (e) {
      if (e.response!.statusCode != 201) {
        log("Resource RESPONSE ${e.response!.data}");
        throw httpErrorHandler(e.response!.data['detail']);
      } else {
        return false;
      }
    }
  }

  Future<List<ResourcesModel>> getResource() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.resourcesUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );
      var data = json.decode(res.body) as List<dynamic>;
      log("testing ${res.statusCode}");
      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }

      log("Data ${data.map((e) => ResourcesModel.fromMap(e)).toList()}");
      return data.map((e) => ResourcesModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> editResource(id, map) async {
    var token = await AppPrefs.getLoginToken();
    var dio = Dio();
    String url = "${ApiUrls.resourcesUrl}/$id/";
    try {
      var res = await dio.put(
        url,
        data: map,
        options: Options(
          //followRedirects: false,
          contentType: 'multipart/form-data',
          headers: {
            "Authorization": "Token $token",
            'Accept': 'application/json'
          },
        ),
      );
      return true;
    } on DioError catch (e) {
      if (e.response!.statusCode != 200) {
        log("1 ${e.response!.data['detail']}");
        throw httpErrorHandler(e.response!.data['detail']);
      } else {
        return false;
      }
    }
  }

  Future<bool> deleteResource(id) async {
    var token = await AppPrefs.getLoginToken();
    String url = "${ApiUrls.resourcesUrl}/$id/";
    try {
      var res = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      // log("error ${res.body}");
      //var data = json.decode(res.body);

      if (res.statusCode != 204) {
        throw httpErrorHandler("no data");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
