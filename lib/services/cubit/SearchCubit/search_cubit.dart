import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/services/data/api_req.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(Normal());

  void pop() {
    emit(Normal());
  }

  void listenToSearch(String cityname) {
    Api _api = Api(cityName: cityname);
    _api.searchWeatherData().listen((event) {
      if (event['status'] == 'loading') {
        emit(Loading());
      } else if (event['status'] == 'unknown-request') {
        emit(UnknownError());
      } else if (event['status'] == 'socket-error') {
        emit(Socket());
      } else if (event['status'] == 'success') {
        emit(GoodRequest(body: event['value']));
      }
    });
  }
}
