import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/data/local/localstorage.dart';

class StoreRecents extends LocalStorage {
  static final SharedPreferences? recents = LocalStorage.pref;

  static List<String>? getRecents() => recents!.getStringList('recents') ?? [];

  // static bool _checkRecentExists(String cityName) {
  //   List<String> _recentPlaces = recents!.getStringList('recents') ?? [];
  //   return _recentPlaces.isNotEmpty ? _recentPlaces.contains(cityName) : false;
  // }

  static Future<void> addRecents(String? cityName) async {
    List<String>? _recents = getRecents();
    if (cityName == null) return;
    if (!_recents!.contains(cityName)) {
      _recents.add(cityName);
      // print(_recents);
      await recents!.setStringList('recents', _recents);
    }
  }

  static void clearRecents() => recents!.setStringList('recents', []);
}
