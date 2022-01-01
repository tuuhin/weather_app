import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/data/local/store_time_format.dart';

part 'timeformat_state.dart';

class TimeFormatCubit extends Cubit<TimeFormatState> {
  TimeFormatCubit() : super(TwelveHourFormat());

  bool _is24Mode = StoreTimeFormat.getUserPreferedTimeFormat() ?? false;

  bool get is24Mode => _is24Mode;

  void toggleMode() {
    _is24Mode = !_is24Mode;
    StoreTimeFormat.setUserPreferedTimeFormat(_is24Mode);
    if (_is24Mode) return emit(TwelveHourFormat());
    emit(TwentyFourHourFormat());
  }
}
