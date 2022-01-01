import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/data/local/store_fav.dart';

import 'package:weatherapp/data/remote/weather_api.dart';
import 'package:weatherapp/domain/models/favourites_model.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(Loading());

  void loadData() async {
    final List<String> _favourites =
        StoreFavourites.getFavourites().reversed.toList();
    if (_favourites.isEmpty) return emit(NoFavourites());
    _loadFavourites(_favourites);
    print('loading data');
  }

  void refreshFavs() {
    emit(Loading());
  }

  void _loadFavourites(List<String> fav) async {
    Api.getFavouritesWeather(fav).listen((event) {
      if (event['status'] == 'loading') {
        emit(Loading());
      } else if (event['status'] == 'internet-absent') {
        emit(InternetAbsent(event['value']));
      } else if (event['status'] == 'bad-request') {
        emit(BadRequest(badReq: event['value']));
      } else if (event['status'] == 'success') {
        emit(Success(favouritesInfo: event['value']));
      } else if (event['status'] == 'unknown') {
        emit(Unknown(event['value']));
      }
    });
  }
}
