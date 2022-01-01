part of 'favourites_cubit.dart';

@immutable
abstract class FavouritesState {}

class Loading extends FavouritesState {}

class InternetAbsent extends FavouritesState {
  final Object? error;
  InternetAbsent(this.error);
}

class Unknown extends FavouritesState {
  final Object? error;
  Unknown(this.error);
}

class BadRequest extends FavouritesState {
  final String? badReq;
  BadRequest({this.badReq});
}

class NoFavourites extends FavouritesState {}

class Success extends FavouritesState {
  final List<FavouriteModel>? favouritesInfo;
  Success({this.favouritesInfo});
}
