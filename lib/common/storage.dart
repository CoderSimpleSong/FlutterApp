/*
 * @Author: 宋佳 
 * @Date: 2022-06-10 09:45:23 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-10 13:11:32
 */

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences? preferences;
  static Future<bool> getInstance() async {
    preferences = await SharedPreferences.getInstance();
    return true;
  }

  static Future<bool> setBoolValue(String key, bool value) {
    return preferences!.setBool(key, value);
  }

  static bool? getBoolValue(String key) {
    return preferences!.getBool(key);
  }

  static Future<bool> setStringValue(String key, String value) {
    return preferences!.setString(key, value);
  }

  static String? getStringValue(String key) {
    return preferences!.getString(key);
  }

  static Future<bool> setDoubleValue(String key, double value) {
    return preferences!.setDouble(key, value);
  }

  static double? getDoubleValue(String key) {
    return preferences!.getDouble(key);
  }

  static Future<bool> setIntValue(String key, int value) {
    return preferences!.setInt(key, value);
  }

  static int? getIntValue(String key) {
    return preferences!.getInt(key);
  }

  //清空指定键的值
  static Future<bool> removeKey(String key) {
    return preferences!.remove(key);
  }

  //清空键值对
  static Future<bool> clearAllKey() {
    return preferences!.clear();
  }
}
