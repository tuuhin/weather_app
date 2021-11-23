part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppLoading extends AppState {}

class AppSuccess extends AppState {
  final HomeModel? model;

  AppSuccess(this.model);
}

class ApiError extends AppState {
  final int? statusCode;
  final String? error;

  ApiError(this.error, {this.statusCode});
}

class AppInternetAbsent extends AppState {}

class AppUnknown extends AppState {}
