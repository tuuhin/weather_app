import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/data/local/localstorage.dart';

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
      _loadFavourites(_favouites);
    }
  }

  void _loadFavourites(List<String> fav) async {
    Api.getFavouritesWeather(fav).listen((event) {
      if (event['status'] == 'loading') {
        emit(Loading());
      } else if (event['status'] == 'internet-absent') {
        emit(InternetAbsent(event['value']));
      } else if (event['status'] == 'bad-request') {
        emit(BadRequest());
      } else if (event['status'] == 'success') {
        emit(Success(favouritesInfo: event['value']));
      } else if (event['status'] == 'time-out') {
        emit(TimeOut(event['value']));
      } else if (event['status'] == 'unknown') {
        emit(Unknown(event['value']));
      }
    });
  }
}
