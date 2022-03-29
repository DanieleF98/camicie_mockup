import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref() {
    initialize();
  }
  final String _themeModeKey = 'theme.mode.key';

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> initialize() async {
    _prefs = SharedPreferences.getInstance();
  }

  Future<void> setInt(String key, int value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(key);
  }

  Future<void> setBool(String key, {required bool value}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }

  Future<void> setDouble(String key, double value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setDouble(key, value);
  }

  Future<void> setString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  Future<double?> getDouble(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getDouble(key);
  }

  Future<void> setThemeData({required bool value}) async {
    await setBool(_themeModeKey, value: value);
  }

  Future<bool> getThemeData() async {
    return await getBool(_themeModeKey) ?? false;
  }
}
