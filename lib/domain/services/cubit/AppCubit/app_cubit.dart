import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/data/local/store_location.dart';
import 'package:weatherapp/data/remote/json_to_model.dart';
import 'package:weatherapp/data/remote/weather_api.dart';
import 'package:weatherapp/domain/models/home_model.dart';
import 'package:weatherapp/domain/utlis.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppLoading());

  void emitLoader() {
    emit(AppLoading());
  }

  Future<bool?> setAsPreferedLocation() async {
    try {
      Position pos = await Utils.getPos();
      await StoreLocation.setUserPreferedLocation(pos.latitude, pos.longitude);
      emitLoader();
    } catch (e) {
      print(e);
      return false;
    }
  }

  void getLocation() {
    Map? userPreferedLocation = StoreLocation.getUserPreferedLocation();

    if (userPreferedLocation == null) {
      Utils.getPos()
          .then((Position pos) => getWeatherBulk(pos.latitude, pos.longitude))
          .onError((error, stackTrace) => emit(AppUnknownErrorType()));
    } else {
      final double latt = userPreferedLocation['lattitude'];
      final double long = userPreferedLocation['longitude'];
      return getWeatherBulk(latt, long);
    }
  }

  void getWeatherBulk(double latt, double long) {
    Api.getBulkData(latt, long).listen((event) {
      // print(event);
      if (event['status'] == 'bad-request') {
        emit(ApiMadeBadRequest(
            error: event['value']['message'],
            statusCode: event['value']['cod']));
      } else if (event['status'] == 'internet-absent') {
        emit(AppInternetAbsent());
      } else if (event['status'] == 'unknown') {
        emit(AppUnknownErrorType());
      } else if (event['status'] == 'success') {
        emit(AppGivesSuccess(
          model: JsonToModel.getModel(event['value']),
        ));
      }
    });
  }
}
