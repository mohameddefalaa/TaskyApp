import 'package:shared_preferences/shared_preferences.dart';

class PerfrenceManager {
  static final PerfrenceManager _instance = PerfrenceManager._internal();
  factory PerfrenceManager() {
    return _instance;
  }
  // private constructor ;
  PerfrenceManager._internal();

  ///
  late final SharedPreferences _preferences;
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getstring(String key) {
    return _preferences.getString(key);
  }

  Future<bool> setstring(String key, String value) {
    return _preferences.setString(key, value);
  }

  Future<bool> setbool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  bool? getbool(String key) {
    return _preferences.getBool(key);
  }

  Future<bool> remove(String key) {
    return _preferences.remove(key);
  }
}
