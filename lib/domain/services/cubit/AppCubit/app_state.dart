part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppLoading extends AppState {}

class AppGivesSuccess extends AppState {
  final HomeModel? model;

  AppGivesSuccess({this.model});
}

class ApiMadeBadRequest extends AppState {
  final dynamic statusCode;
  final String? error;

  ApiMadeBadRequest({this.error, this.statusCode});
}

class AppInternetAbsent extends AppState {}

class AppUnknownErrorType extends AppState {}
