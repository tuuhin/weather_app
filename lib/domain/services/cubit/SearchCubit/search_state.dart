part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class Normal extends SearchState {}

class Search extends SearchState {}

class Loading extends SearchState {}

class GoodRequest extends SearchState {
  final SummaryModel? data;
  GoodRequest({this.data});
}

class BadRequest extends SearchState {}

class Socket extends SearchState {}

class UnknownError extends SearchState {}
