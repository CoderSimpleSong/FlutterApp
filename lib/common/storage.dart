import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  static Future<bool> setBoolValue(String key,bool value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setBool(key,value);
  }

  static Future<bool> getBoolValue(String key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }

  static Future<bool> setStringValue(String key,String value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(key,value);
  }

  static Future<String> getStringValue(String key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  static Future<bool> setDoubleValue(String key,double value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setDouble(key,value);
  }

  static Future<double> getDoubleValue(String key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getDouble(key);
  }

  static Future<bool> setIntValue(String key,int value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setInt(key,value);
  }

  static Future<int> getIntValue(String key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }

  //清空指定键的值
  static Future<bool> removeKey(String key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }

  //清空键值对
  static Future<bool> clearAllKey() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}