part of 'favourites_cubit.dart';

@immutable
abstract class FavouritesState {}

class Loading extends FavouritesState {}

class Socket extends FavouritesState {}

class UnknownError extends FavouritesState {}

class BadRequest extends FavouritesState {}

class NoFavourites extends FavouritesState {}

class Success extends FavouritesState {
  final List<FavouriteModel>? favouritesInfo;
  Success({this.favouritesInfo});
}
