// ignore_for_file: depend_on_referenced_packages, unused_local_variable
import 'dart:developer';

import 'package:grocery/Application/exports.dart';
import 'package:http/http.dart' as http;

class UserServices {
  Future<List<UserModel>> getUser() async {
    var token = await AppPrefs.getLoginToken();
    List<UserModel> list = List.empty(growable: true);
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.userUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      var data = json.decode(res.body);

      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }

      log("Data ${UserModel.fromMap(data)}");
      var newData = UserModel.fromMap(data);
      list.add(newData);

      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> editUser(map) async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.put(
        Uri.parse(ApiUrls.userUrl),
        body: map,
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      log("Data ${res.body}");
      if (res.statusCode != 200) {
        throw httpErrorHandler("no data");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteAccount(id) async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.delete(
        Uri.parse('${ApiUrls.deleteUrl}/$id'),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      log("Data ${res.body}");
      if (res.statusCode != 204) {
        throw httpErrorHandler("no data");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
