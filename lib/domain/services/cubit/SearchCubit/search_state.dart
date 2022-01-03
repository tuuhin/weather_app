part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class ShowRecents extends SearchState {}

class SearchingResult extends SearchState {}

class GoodRequest extends SearchState {
  final SummaryModel? data;
  GoodRequest({this.data});
}

class ApiGivesBadRequest extends SearchState {
  final String? error;
  final dynamic errorCode;
  ApiGivesBadRequest({this.error, this.errorCode});
}

class AppInternetAbsent extends SearchState {}

class AppUnknownError extends SearchState {}
