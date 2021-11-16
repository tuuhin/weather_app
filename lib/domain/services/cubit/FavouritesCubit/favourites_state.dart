part of 'favourites_cubit.dart';

@immutable
abstract class FavouritesState {}

class Loading extends FavouritesState {}

class Failed extends FavouritesState {}

class Success extends FavouritesState {
  final List<FavouriteModel>? favouritesInfo;
  Success({this.favouritesInfo});
}
