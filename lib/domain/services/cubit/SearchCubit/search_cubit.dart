import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/data/remote/json_to_model.dart';
import 'package:weatherapp/data/remote/weather_api.dart';
import 'package:weatherapp/domain/models/models.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(ShowRecents());

  void showRecents() {
    emit(ShowRecents());
  }

  void getDataFromCoord(double latt, double long) {
    Api.currentPosWeather(latt, long).listen((event) {
      if (event['status'] == 'loading') {
        emit(SearchingResult());
      } else if (event['status'] == 'bad-request') {
        emit(ApiGivesBadRequest());
      } else if (event['status'] == 'internet-absent') {
        emit(AppInternetAbsent());
      } else if (event['status'] == 'success') {
        emit(GoodRequest(data: JsonToModel.toSummary(event['value'])));
      } else if (event['status'] == 'unknown') {
        emit(AppUnknownError());
      }
    });
  }

  void getCity(String cityname) {
    Api.searchWeatherData(cityname).listen((event) {
      if (event['status'] == 'loading') {
        emit(SearchingResult());
      } else if (event['status'] == 'bad-request') {
        emit(ApiGivesBadRequest(
          error: event['value']['message'],
          errorCode: event['value']['cod'],
        ));
      } else if (event['status'] == 'internet-absent') {
        emit(AppInternetAbsent());
      } else if (event['status'] == 'success') {
        emit(GoodRequest(data: JsonToModel.toSummary(event['value'])));
      } else if (event['status'] == 'unknown') {
        emit(AppUnknownError());
      }
    });
  }
}
