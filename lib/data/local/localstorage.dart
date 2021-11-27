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
          await _pref!.setStringList('favourite', _recents);
          // print(_recents);
          return true;
        }
      }
    }
  }

  static setCurrentLocation(double latt, double long) async {
    await _pref!.setDouble('lattitude', latt);
    await _pref!.setDouble('longitude', long);
  }

  static getCurrentLocation() {
    return [_pref!.getDouble('lattitude'), _pref!.getDouble('longitude')];
  }

  static bool checkPreviousLocation() {
    double? _latt = _pref!.getDouble('lattitude');
    double? _long = _pref!.getDouble('longitude');
    if (_latt == null && _long == null) {
      return false;
    } else {
      return true;
    }
  }

  static clearHistory() async {
    await _pref!.setStringList('recents', []);
  }

  static clearFavorites() async {
    await _pref!.setStringList('favourite', []);
  }
}
