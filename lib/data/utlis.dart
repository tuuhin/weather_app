import 'package:geolocator/geolocator.dart';

class Utils {
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
}
