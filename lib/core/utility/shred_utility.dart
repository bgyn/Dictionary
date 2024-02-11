import 'package:shared_preferences/shared_preferences.dart';

class SharedUtility {
  static SharedUtility? _instance;
  static SharedPreferences? _prefs;
  factory SharedUtility() {
    if (_instance == null) {
      throw Exception('AppSharedPrefs is not initialized. '
          'Please call SharedUtility.ensureInitialize before');
    }
    return _instance!;
  }
  const SharedUtility._();

  static ensureInitialized() async {
    _prefs ??= await SharedPreferences.getInstance();
    _instance ??= const SharedUtility._();
  }

  static const _themeKey = 'theme';

  bool themeMode() {
    final themevalue = _prefs!.getBool(_themeKey);
    if (themevalue == null) return false;
    return themevalue;
  }

  Future<void> updateThemeMode(bool value) async {
    await _prefs!.setBool(_themeKey, value);
  }
}
