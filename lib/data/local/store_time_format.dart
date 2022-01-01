import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/data/local/localstorage.dart';

class StoreTimeFormat extends LocalStorage {
  static final SharedPreferences? timeFormat = LocalStorage.pref;

  static getUserPreferedTimeFormat() => timeFormat!.getBool('is24Hour');
  static Future<void> setUserPreferedTimeFormat(bool is12Hour) async =>
      await timeFormat!.setBool('is24Hour', is12Hour);
}
