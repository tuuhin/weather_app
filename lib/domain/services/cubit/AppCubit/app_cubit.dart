import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/data/remote/json_to_model.dart';
import 'package:weatherapp/data/remote/weather_api.dart';
import 'package:weatherapp/domain/models/home_model.dart';
import 'package:weatherapp/domain/utlis.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppLoading());

  void getLocation() {
    Utils.getPos()
        .then((Position pos) => getWeatherBulk(pos.latitude, pos.longitude))
        .onError((String? error, stackTrace) async {
      final _location = await Utils.getlocationInMemory();
      getWeatherBulk(_location[0], _location[1]);
    });
  }

  void getWeatherBulk(num latt, num long) {
    Api.getBulkData(latt, long).listen((event) {
      print(event);
      if (event['status'] == 'bad-request') {
        emit(ApiError(event['value']['message'],
            statusCode: event['value']['cod']));
      } else if (event['status'] == 'internet-absent') {
        emit(AppInternetAbsent());
      } else if (event['status'] == 'unknown') {
        emit(AppUnknown());
      } else if (event['status'] == 'success') {
        emit(AppSuccess(JsonToModel.getModel(event['value'])));
      }
    });
  }
}
