import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/data/remote/json_to_model.dart';
import 'package:weatherapp/data/remote/weather_api.dart';
import 'package:weatherapp/domain/models/models.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(Normal());

  void showRecents() {
    emit(Normal());
  }

  void getDataFromCoord(double latt, double long) {
    Api.currentPosWeather(latt, long).listen((event) {
      if (event['status'] == 'loading') {
        emit(Loading());
      } else if (event['status'] == 'bad-request') {
        emit(BadRequest());
      } else if (event['status'] == 'internet-absent') {
        emit(InternetAbsent(event['error']));
      } else if (event['status'] == 'success') {
        emit(GoodRequest(data: JsonToModel.toSummary(event['value'])));
      } else if (event['status'] == 'unknown') {
        emit(Unknown(event['value']));
      }
    });
  }

  void getCity(String cityname) {
    Api.searchWeatherData(cityname).listen((event) {
      if (event['status'] == 'loading') {
        emit(Loading());
      } else if (event['status'] == 'bad-request') {
        emit(BadRequest(
          error: event['value']['message'],
          errorCode: event['value']['cod'],
        ));
      } else if (event['status'] == 'internet-absent') {
        emit(InternetAbsent(event['error']));
      } else if (event['status'] == 'success') {
        emit(GoodRequest(data: JsonToModel.toSummary(event['value'])));
      } else if (event['status'] == 'unknown') {
        emit(Unknown(event['value']));
      }
    });
  }
}
