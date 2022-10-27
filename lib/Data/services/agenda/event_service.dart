// ignore_for_file: unused_local_variable, depend_on_referenced_packages
import 'dart:convert';
import 'dart:developer';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Data/errors/http_error_handler.dart';
import 'package:grocery/Domain/models/manager/event_model.dart';
import 'package:http/http.dart' as http;

class EventService {
  Future<bool> addEvent(map) async {
    var token = await AppPrefs.getLoginToken();
    var bytes = utf8.encode(json.encode(map));
    try {
      var res = await http.post(
        Uri.parse(ApiUrls.eventUrl),
        body: bytes,
        headers: {
          "Authorization": "Token $token",
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var data = json.decode(res.body);
      log("Event Response $data");
      log("testing ${res.statusCode}");
      if (res.statusCode != 201) {
        throw httpErrorHandler("An error occured, Please try again!!!");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EventModel>> getEvent() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.eventUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("testing ${res.statusCode}");
      var data = json.decode(res.body) as List<dynamic>;
      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      }
      log("Data ${data.map((e) => EventModel.fromMap(e)).toList()}");
      return data.map((e) => EventModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> editEvent(id, map) async {
    var token = await AppPrefs.getLoginToken();
    var bytes = utf8.encode(json.encode(map));
    String url = "${ApiUrls.eventUrl}/$id/";

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
      log("testing ${res.statusCode}");
      if (res.statusCode != 200) {
        throw httpErrorHandler("An error occured, please try again!!!");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteEvent(id) async {
    var token = await AppPrefs.getLoginToken();
    String url = "${ApiUrls.eventUrl}/$id/";
    try {
      var res = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $token",
        },
      );
      log("Response ${res.statusCode}");
      if (res.statusCode != 204) {
        throw httpErrorHandler("not found");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
