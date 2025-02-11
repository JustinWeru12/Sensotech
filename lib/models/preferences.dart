import 'dart:convert';

import 'package:sensotech/classes/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<int?> getClientID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? data = prefs.getInt('clientID');
    return data;
  }

  static Future<void> setClientID(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('clientID', id);
  }

  static Future<UserData?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('user');
    if (data != null) {
      return UserData.fromMap(json.decode(data));
    }
    return null;
  }

  static Future<void> setUser(UserData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(data.toMap()));
  }

  static Future<bool> getHideStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hide') ?? true;
  }

  static Future setHideStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('hide', value);
  }

  static Future<int?> getCheckStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('check');
  }

  static Future setCheckStatus(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('check', value);
  }

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    prefs.remove("clientID");
  }
}
