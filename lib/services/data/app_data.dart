import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  static SharedPreferences? _pref;
  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static getRecents() {
    return _pref!.getStringList('recents');
  }

  static newRecent(String newName) {
    List<String>? prev = _pref!.getStringList('recents');
    if (prev != null) {
      prev.add(newName);
      _pref!.setStringList('recents', prev);
    } else {
      _pref!.setStringList('recents', [newName]);
    }
  }

  static clearHistory() {
    _pref!.setStringList('recents', []);
  }
}
