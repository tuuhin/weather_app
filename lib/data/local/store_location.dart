import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/data/local/localstorage.dart';

class StoreLocation extends LocalStorage {
  static final SharedPreferences? locationPreference = LocalStorage.pref;
  static Map? getUserPreferedLocation() {
    double? lattitude = locationPreference!.getDouble('prefered_lattitude');
    double? longitude = locationPreference!.getDouble('prefered_longitude');
    if (lattitude == null && longitude == null) return null;
    return {'lattitude': lattitude, 'longitude': longitude};
  }

  static Future<void> setUserPreferedLocation(
      num? lattitude, num? longitude) async {
    await locationPreference!
        .setDouble('prefered_lattitude', lattitude!.toDouble());
    await locationPreference!
        .setDouble('prefered_longitude', longitude!.toDouble());
  }
}
