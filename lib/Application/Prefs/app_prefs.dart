// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:grocery/Application/Prefs/prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static Future<void> setLoginToken(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(AppPrefsKeys.loginKey, token);
  }

  static Future<String> getLoginToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var loginToken = _prefs.getString(AppPrefsKeys.loginKey) ?? "";
    return loginToken;
  }

  static Future<void> setUserEmail(String userEmail) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(AppPrefsKeys.userEmail, userEmail);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var userEmail = _prefs.getString(AppPrefsKeys.userEmail) ?? "";
    return userEmail;
  }
}
