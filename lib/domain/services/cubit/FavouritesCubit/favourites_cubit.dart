import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/data/local/localstorage.dart';
import 'package:weatherapp/data/remote/json_to_model.dart';
import 'package:weatherapp/data/remote/weather_api.dart';
import 'package:weatherapp/domain/models/favourites_model.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(Loading());

  final List<String> _favouites = LocalStorage.getFavourites();

  void loadData() async {
    List<FavouriteModel> _data = [];
    for (String place in _favouites) {
      Api(cityName: place).searchWeatherData().listen((event) {
        if (event['status'] == 'success') {
          _data.add(JsonToModel.toCard(event['value']));
        }
      });
    }
    await Future.delayed(const Duration(seconds: 5));
    emit(Success(favouritesInfo: _data));
  }
}
