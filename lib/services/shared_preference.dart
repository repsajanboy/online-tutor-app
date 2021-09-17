import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }
  setIsLogin(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
  Future<bool> getIsLogin(String key) async {
    final prefs = await SharedPreferences.getInstance();
    bool loginTrue = prefs.getBool(key);
    return loginTrue;
  }
  Future<bool> isExisting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    bool exist = prefs.containsKey(key);
    return exist;
  }
}
