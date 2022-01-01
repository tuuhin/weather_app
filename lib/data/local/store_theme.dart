import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/data/local/localstorage.dart';

class StoreTheme extends LocalStorage {
  static final SharedPreferences? themePreference = LocalStorage.pref;
  static bool? getUserPreferedTheme() => themePreference!.getBool('isDark');

  static Future<void> setUserPreferedTheme(bool isDark) async =>
      await themePreference!.setBool('isDark', isDark);
}
