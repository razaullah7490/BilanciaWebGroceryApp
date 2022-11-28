// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:grocery/Application/exports.dart';

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

  static Future<void> setUserFirstName(String firstName) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(AppPrefsKeys.userFirstName, firstName);
  }

  static Future<String> getUserFirstName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var firstName = _prefs.getString(AppPrefsKeys.userFirstName) ?? "";
    return firstName;
  }

  static Future<void> setUserLastName(String lastName) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(AppPrefsKeys.userLastName, lastName);
  }

  static Future<String> getUserLastName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var lastName = _prefs.getString(AppPrefsKeys.userLastName) ?? "";
    return lastName;
  }

  static Future<void> setUserId(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(AppPrefsKeys.userId, id);
  }

  static Future<String> getUserId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var id = _prefs.getString(AppPrefsKeys.userId) ?? "";
    return id;
  }

  static Future<void> setUserPassword(String password) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(AppPrefsKeys.userPassword, password);
  }

  static Future<String> getUserPassword() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var password = _prefs.getString(AppPrefsKeys.userPassword) ?? "";
    return password;
  }

  static Future<void> setProcessedResourceId(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(AppPrefsKeys.processedResourceId, id);
  }

  static Future<String> getProcessedResourceId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var id = _prefs.getString(AppPrefsKeys.processedResourceId) ?? "";
    return id;
  }
}
