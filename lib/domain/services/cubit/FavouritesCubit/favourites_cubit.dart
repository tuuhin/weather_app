import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/data/local/localstorage.dart';
import 'package:weatherapp/data/remote/json_to_model.dart';
import 'package:weatherapp/data/remote/weather_api.dart';
import 'package:weatherapp/domain/models/favourites_model.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(Loading());

  void loadData() async {
    final List<String> _favouites =
        LocalStorage.getFavourites().reversed.toList();
    if (_favouites.isEmpty) {
      emit(NoFavourites());
    } else {
      _getDataFromAPi(_favouites);
    }
  }

  void _getDataFromAPi(List<String> fav) async {
    Api.getFavouritesWeather(fav).listen((event) {
      if (event == 'loading') {
        emit(Loading());
      } else if (event['status'] == 'socket-error') {
        emit(Socket());
      } else if (event['status'] == 'bad-request') {
        emit(BadRequest());
      } else if (event['status'] == 'success') {
        emit(Success(favouritesInfo: event['value']));
      } else if (event['status'] == 'unknown-request') {
        emit(UnknownError());
      }
    });
  }
}
