part of 'favourites_cubit.dart';

@immutable
abstract class FavouritesState {}

class LoadingFavourites extends FavouritesState {}

class AppInternetAbsent extends FavouritesState {
  final Object? error;
  AppInternetAbsent(this.error);
}

class AppUnknownError extends FavouritesState {
  final Object? error;
  AppUnknownError(this.error);
}

class ApiGivesBadResult extends FavouritesState {
  final String? badReq;
  ApiGivesBadResult({this.badReq});
}

class NoUsersFavourites extends FavouritesState {}

class FavouritesSuccess extends FavouritesState {
  final List<FavouriteModel>? favouritesInfo;
  FavouritesSuccess({this.favouritesInfo});
}
