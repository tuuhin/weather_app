import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/domain/services/cubit/DataProvider/dataprovider_cubit.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataproviderCubit _data = BlocProvider.of<DataproviderCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(_data.model!.place ?? 'Zone absent'),
              Text(_data.model!.temperature!.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.headline2),
              Chip(
                  label: Text(_data.model!.weatherMain ?? '',
                      style: Theme.of(context).textTheme.bodyText1))
            ],
          ),
          _data.model!.weatherIconId != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 3),
                  child: Image.asset(
                      'assets/icon/${_data.model!.weatherIconId}.png',
                      scale: 3),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
