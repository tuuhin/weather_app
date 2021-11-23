import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/domain/models/home_model.dart';

part 'dataprovider_state.dart';

class DataproviderCubit extends Cubit<DataproviderState> {
  final HomeModel? model;
  DataproviderCubit(this.model) : super(DataproviderInitial());
}
