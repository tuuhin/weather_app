import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';

class Utils {
  static Future<String?> locationFromCoordinate(num? latt, num? long) async {
    try {
      if (latt != null && long != null) {
        List<Placemark> _places =
            await placemarkFromCoordinates(latt.toDouble(), long.toDouble());
        // print(_places.first);
        if (_places.first.subLocality != '') return _places.first.subLocality;
        if (_places.first.locality != '') return _places.first.locality;
        if (_places.first.subAdministrativeArea != '') {
          return _places.first.subAdministrativeArea;
        }
        if (_places.first.street != '') return _places.first.street;
        if (_places.first.administrativeArea != '') {
          return _places.first.administrativeArea;
        }
        if (_places.first.country != '') return _places.first.country;
      }
    } catch (e) {
      print(e.toString());
    }
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

  static String readTimeStamp(bool is24Hr, int unixTimeStamp) {
    DateFormat format = DateFormat(is24Hr ? 'Hm' : 'jm');
    DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimeStamp * 1000);
    return format.format(date);
  }

  // static String readTimeStamp(int unixTimeStamp) {
  //   DateFormat format = DateFormat('jm');
  //   DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimeStamp * 1000);
  //   return format.format(date);
  // }

  // static String timeStamp24hr(int unixTimeStamp) {
  //   DateFormat format = DateFormat('Hm');
  //   DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimeStamp * 1000);

  //   return format.format(date);
  // }

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
