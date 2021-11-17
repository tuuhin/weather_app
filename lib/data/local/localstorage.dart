import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _pref;
  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static List<String> getFavourites() {
    return _pref!.getStringList('favourite') ?? [];
  }

  static getRecents() {
    return _pref!.getStringList('recents');
  }

  static recent(String? cityname) async {
    List<String> _recents = _pref!.getStringList('recents') ?? [];
    if (cityname != null) {
      if (!_isRecent(cityname)) {
        if (!_recents.contains(cityname)) {
          _recents.add(cityname);
          // print(_recents);
          await _pref!.setStringList('recents', _recents);
        }
      }
    }
  }

  static bool _isRecent(String cityname) {
    List<String> oldFavourites = _pref!.getStringList('recents') ?? [];
    return oldFavourites.isEmpty ? false : oldFavourites.contains(cityname);
  }

  static bool isFav(String cityname) {
    List<String> oldFavourites = _pref!.getStringList('favourite') ?? [];
    return oldFavourites.isEmpty ? false : oldFavourites.contains(cityname);
  }

  static Future<bool?> addFavourite(String? cityname) async {
    List<String> _recents = _pref!.getStringList('favourite') ?? [];
    if (cityname != null) {
      if (!isFav(cityname)) {
        if (!_recents.contains(cityname)) {
          _recents.add(cityname);
          await _pref!.setStringList('recents', _recents);
          return true;
        }
      }
    }
  }

  static clearHistory() async {
    await _pref!.setStringList('recents', []);
  }
}
