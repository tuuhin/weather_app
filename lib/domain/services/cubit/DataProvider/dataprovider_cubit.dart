import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/domain/models/home_model.dart';

part 'dataprovider_state.dart';

class DataProviderCubit extends Cubit<DataProviderState> {
  final HomeModel? model;
  DataProviderCubit(this.model) : super(DataProvider());
}
