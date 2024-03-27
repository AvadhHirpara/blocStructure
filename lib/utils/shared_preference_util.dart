import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferenceUtil {
  static SharedPreferenceUtil? _singleton;
  static SharedPreferences? _prefs;

  static Future<SharedPreferenceUtil?> getInstance() async {
    if (_singleton == null) {
      var singleton = SharedPreferenceUtil._();
      await singleton._init();
      _singleton = singleton;
    }
    return _singleton;
  }

  SharedPreferenceUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? encode(Object? value) => value == null ? '' : json.encode(value);

  static dynamic decode(String? value) => value == null || value.isEmpty ? null : json.decode(value);

  static Future<bool> putValue<T>(String key, T value) async {
    if (_prefs == null) return false;
    if (T == String) {
      return _prefs!.setString(key, value as String);
    } else if (T == bool) {
      return _prefs!.setBool(key, value as bool);
    } else if (T == int) {
      return _prefs!.setInt(key, value as int);
    } else if (T == double) {
      return _prefs!.setDouble(key, value as double);
    }
    return false;
  }

  static String getString(String key, {String defValue = ''}) => _prefs?.getString(key) ?? defValue;

  static bool getBool(String key, {bool defValue = false}) => _prefs?.getBool(key) ?? defValue;

  static int getInt(String key, {int defValue = 0}) => _prefs?.getInt(key) ?? defValue;

  static double getDouble(String key, {double defValue = 0.0}) => _prefs?.getDouble(key) ?? defValue;

  static List<String> getStringList(String key, {List<String> defValue = const []}) => _prefs?.getStringList(key) ?? defValue;

  static dynamic getDynamic(String key, {Object? defValue}) => _prefs?.get(key) ?? defValue;

  static bool? haveKey(String key) => _prefs?.getKeys().contains(key);

  static Set<String>? getKeys() => _prefs?.getKeys();

  static bool isInitialized() => _prefs != null;

  /*-------------------------------------------*/
/*  static UserData? getUserData() {
    var user = getString(userDataKey);
    return  user == "" ? null : UserData.fromJson(jsonDecode(user));
  }

  static Future<bool> saveUserData({UserData? userData}) {
    return putValue(userDataKey, jsonEncode(userData?.toJson()));
  }*/

}
