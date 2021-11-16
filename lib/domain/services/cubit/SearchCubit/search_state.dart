part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class Normal extends SearchState {}

class Search extends SearchState {}

class Loading extends SearchState {}

class GoodRequest extends SearchState {
  Map<String, dynamic>? body;
  GoodRequest({this.body});
}

class BadRequest extends SearchState {}

class Socket extends SearchState {}

class UnknownError extends SearchState {}
