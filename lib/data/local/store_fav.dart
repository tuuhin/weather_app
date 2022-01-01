import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/data/local/localstorage.dart';

class StoreFavourites extends LocalStorage {
  static final SharedPreferences? favourites = LocalStorage.pref;

  static List<String> getFavourites() =>
      favourites!.getStringList('favourites') ?? [];

  static Future<bool> updateFavourites(String? cityName) async {
    if (cityName == null) return false;
    final List<String>? fav = getFavourites();
    if (!fav!.contains(cityName)) {
      fav.add(cityName);
      await favourites!.setStringList('favourites', fav);
      return true;
    } else {
      fav.remove(cityName);
      await favourites!.setStringList('favourites', fav);
      return false;
    }
  }

  static bool isFavourite(String? cityName) {
    if (cityName == null) return false;
    final List<String>? fav = getFavourites();
    return fav!.contains(cityName);
  }

  static void clearFavourites() => favourites!.setStringList('favourites', []);
}
