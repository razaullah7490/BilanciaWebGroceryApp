// ignore_for_file: depend_on_referenced_packages
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:grocery/Application/exports.dart';

class ProductService {
  static Future addProduct(map) async {
    var token = await AppPrefs.getLoginToken();

    try {
      var headers = {'Authorization': 'Token $token'};
      var request =
          http.MultipartRequest('OPTIONS', Uri.parse(ApiUrls.productUrl));

      request.fields.addAll(map);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        log("status code 200 ${await response.stream.bytesToString()}");
      } else {
        log("Response phrase ${response.reasonPhrase}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
