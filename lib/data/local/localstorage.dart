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

  static newRecent(String newName) async {
    List<String> prev = _pref!.getStringList('recents') ?? [];
    if (!prev.contains(newName)) {
      if (prev.isNotEmpty) {
        prev.add(newName);
        await _pref!.setStringList('recents', prev);
      } else {
        await _pref!.setStringList('recents', [newName]);
      }
    }
  }

  static bool isFav(String cityname) {
    List<String> oldFavourites = _pref!.getStringList('favourite') ?? [];
    return oldFavourites.isEmpty ? false : oldFavourites.contains(cityname);
  }

  static Future<bool> newFavourite(String? newName) async {
    List<String>? oldFavourites = _pref!.getStringList('favourite') ?? [];
    print(oldFavourites);
    if (newName != null) {
      if (!oldFavourites.contains(newName)) {
        if (oldFavourites.isNotEmpty) {
          oldFavourites.add(newName);
          await _pref!.setStringList('favourite', oldFavourites);
        } else {
          await _pref!.setStringList('favourite', [newName]);
        }
        return true;
      } else {
        oldFavourites.remove(newName);
        await _pref!.setStringList('favourite', oldFavourites);
        return false;
      }
    } else {
      return false;
    }
  }

  static clearHistory() async {
    await _pref!.setStringList('recents', []);
  }
}
