// ignore_for_file: unused_local_variable, depend_on_referenced_packages
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:grocery/Application/exports.dart';

class AllUsersService {
  Future<List<AllUsersModel>> getAllUsers() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.getAllUsersUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      var data = json.decode(res.body) as List<dynamic>;
      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }
      log("Data ${data.map((e) => AllUsersModel.fromMap(e)).toList()}");
      return data.map((e) => AllUsersModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
