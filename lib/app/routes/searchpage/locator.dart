import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({Key? key}) : super(key: key);
  Future<Position> _getPos() async {
    bool _enabled;
    LocationPermission permission;
    _enabled = await Geolocator.isLocationServiceEnabled();
    if (!_enabled) {
      //not allowed
      return Future.error('Location permission are dissabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('permission are denied forever');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    SearchCubit _searchCubit = BlocProvider.of<SearchCubit>(context);
    return GestureDetector(
      onTap: () async {
        Position _pos = await _getPos();
        _searchCubit.getDataFromCoord(_pos.latitude, _pos.longitude);
      },
      child: const Chip(
        avatar: Icon(Icons.place),
        label: Text('Current Location'),
      ),
    );
  }
}
