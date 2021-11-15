import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'changetheme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  ChangeThemeCubit() : super(LightTheme());
  bool _dark = false;
  bool get dark => _dark;

  void toggletheme() {
    _dark = !_dark;
    if (_dark) {
      emit(LightTheme());
    } else {
      emit(DarkTheme());
    }
  }
}
