import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/domain/utlis.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchCubit _searchCubit = BlocProvider.of<SearchCubit>(context);
    return GestureDetector(
      onTap: () async {
        Utils.getPos()
            .then((Position _pos) =>
                _searchCubit.getDataFromCoord(_pos.latitude, _pos.longitude))
            .onError((error, stackTrace) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('$error'))));
      },
      child: const Chip(
        avatar: Icon(Icons.place),
        label: Text('Current Location'),
      ),
    );
  }
}
