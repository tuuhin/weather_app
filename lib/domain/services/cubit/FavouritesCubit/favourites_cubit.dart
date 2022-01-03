import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/data/local/store_fav.dart';

import 'package:weatherapp/data/remote/weather_api.dart';
import 'package:weatherapp/domain/models/favourites_model.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(LoadingFavourites());

  void loadData() async {
    final List<String> _favourites =
        StoreFavourites.getFavourites().reversed.toList();
    if (_favourites.isEmpty) return emit(NoUsersFavourites());
    _loadFavourites(_favourites);
    print('loading data');
  }

  void refreshFavs() {
    emit(LoadingFavourites());
  }

  void _loadFavourites(List<String> fav) async {
    Api.getFavouritesWeather(fav).listen((event) {
      if (event['status'] == 'loading') {
        emit(LoadingFavourites());
      } else if (event['status'] == 'internet-absent') {
        emit(AppInternetAbsent(event['value']));
      } else if (event['status'] == 'bad-request') {
        emit(ApiGivesBadResult(badReq: event['value']));
      } else if (event['status'] == 'success') {
        emit(FavouritesSuccess(favouritesInfo: event['value']));
      } else if (event['status'] == 'unknown') {
        emit(AppUnknownError(event['value']));
      }
    });
  }
}
