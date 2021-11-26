import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weatherapp/data/local/localstorage.dart';

class Utils {
  static Future<String?> locationFromCoordinate(
      double latt, double long) async {
    try {
      List<Placemark> _places = await placemarkFromCoordinates(latt, long);

      return _places.first.locality ?? _places.first.subLocality;
    } catch (e) {
      print(e.toString());
    }
  }

  static getlocationInMemory() async {
    if (!LocalStorage.checkPreviousLocation()) {
      await LocalStorage.setCurrentLocation(28.6139, 77.2090);
    }
    return LocalStorage.getCurrentLocation();
  }

  static Future<Position> getPos() async {
    bool _enabled;
    LocationPermission permission;
    _enabled = await Geolocator.isLocationServiceEnabled();
    if (!_enabled) {
      //not allowed
      return Future.error('Location permission are dissabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('permission are denied forever');
    }
    return await Geolocator.getCurrentPosition();
  }

  static String readTimeStamp(int unixTimeStamp) {
    DateFormat format = DateFormat('jm');
    DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimeStamp * 1000);

    return format.format(date);
  }

  static String timeStamp24hr(int unixTimeStamp) {
    DateFormat format = DateFormat('Hm');
    DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimeStamp * 1000);

    return format.format(date);
  }

  static String timestamptoDate(int unixTimeStamp) {
    DateFormat format = DateFormat('Md');
    DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimeStamp * 1000);

    return format.format(date);
  }

  static String readDay(int unixTimeStamp) {
    DateFormat format = DateFormat('EEEE');
    DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimeStamp * 1000);

    return format.format(date);
  }

  static String showDateforDetails(int unixTimeStamp) {
    DateFormat formatDate = DateFormat('MMMEd');
    DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimeStamp * 1000);

    return formatDate.format(date);
  }
}
