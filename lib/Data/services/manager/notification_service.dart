// ignore_for_file: unused_local_variable, depend_on_referenced_packages
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:grocery/Application/exports.dart';

class NotificationService {
  Future<List<NotificationModel>> getNotifications() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.notificationUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      var data = json.decode(res.body) as List<dynamic>;
      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }
      return data.map((e) => NotificationModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> editNotification(id) async {
    var token = await AppPrefs.getLoginToken();
    String url = "${ApiUrls.notificationUrl}/$id/";
    try {
      var res = await http.put(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("Status Code ${res.statusCode}");
      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }
}
