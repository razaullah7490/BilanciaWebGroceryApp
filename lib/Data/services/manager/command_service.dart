// ignore_for_file: unused_local_variable, depend_on_referenced_packages
import 'dart:convert';
import 'dart:developer';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Application/api_urls.dart';
import 'package:grocery/Data/errors/http_error_handler.dart';
import 'package:http/http.dart' as http;
import '../../../Domain/models/manager/command_model.dart';

class CommandService {
  Future<List<CommandModel>> getCommands() async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.commandUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );

      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      } else {
        var commandId = await json.decode(res.body);
        var id = await commandId[0]['id'];
        String url = "${ApiUrls.commandUrl}/$id/command/";
        log("testing1 ${res.statusCode}");
        log("Command Id ${commandId[0]['id']}");

        var commandRes = await http.get(
          Uri.parse(url),
          headers: {
            "Authorization": "Token $token",
          },
        );
        log("testing2 ${commandRes.statusCode}");
        var commandBody = await json.decode(commandRes.body) as List<dynamic>;
        log("Data ${commandBody.map((e) => CommandModel.fromMap(e)).toList()}");
        return commandBody.map((e) => CommandModel.fromMap(e)).toList();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addCommands(commandType) async {
    var token = await AppPrefs.getLoginToken();
    Map<String, dynamic> map = {"command_type": commandType};
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.commandUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );

      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      } else {
        var commandId = await json.decode(res.body);
        var id = await commandId[0]['id'];
        String url = "${ApiUrls.commandUrl}/$id/command/";
        log("testing1 ${res.statusCode}");
        log("Command Id ${commandId[0]['id']}");

        var commandRes = await http.post(
          Uri.parse(url),
          body: map,
          headers: {
            "Authorization": "Token $token",
          },
        );
        log("testing2 ${commandRes.statusCode}");
        log("body ${commandRes.body}");
        if (commandRes.statusCode == 201) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteCommand(commandTypeId) async {
    var token = await AppPrefs.getLoginToken();
    try {
      var res = await http.get(
        Uri.parse(ApiUrls.commandUrl),
        headers: {
          "Authorization": "Token $token",
        },
      );

      if (res.statusCode != 200) {
        throw httpErrorHandler("No data");
      } else {
        var commandId = await json.decode(res.body);
        var id = await commandId[0]['id'];
        String url = "${ApiUrls.commandUrl}/$id/command/$commandTypeId/";

        var commandRes = await http.delete(
          Uri.parse(url),
          headers: {
            "Authorization": "Token $token",
          },
        );

        if (commandRes.statusCode == 204) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
