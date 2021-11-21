part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class Normal extends SearchState {}

class Loading extends SearchState {}

class GoodRequest extends SearchState {
  final SummaryModel? data;
  GoodRequest({this.data});
}

class BadRequest extends SearchState {}

class InternetAbsent extends SearchState {
  final Object? error;
  InternetAbsent(this.error);
}

class Unknown extends SearchState {
  final Object? error;
  Unknown(this.error);
}

class TimeOut extends SearchState {
  final Object? error;
  TimeOut(this.error);
}
