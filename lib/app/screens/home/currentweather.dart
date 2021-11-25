import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/data/local/localstorage.dart';
import 'package:weatherapp/domain/utlis.dart';
import 'package:weatherapp/domain/services/cubit/DataProvider/dataprovider_cubit.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather>
    with AutomaticKeepAliveClientMixin<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    DataproviderCubit _data = BlocProvider.of<DataproviderCubit>(context);

    LocalStorage.setCurrentLocation(
        _data.model!.lattitude ?? 0, _data.model!.longitude ?? 0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              FutureBuilder(
                  future: Utils.locationFromCoordinate(
                      _data.model!.lattitude ?? 0, _data.model!.longitude ?? 0),
                  builder: (context, AsyncSnapshot<String?> snapshot) {
                    print(snapshot.data);
                    return Text(
                      snapshot.data ?? '',
                    );
                  }),
              Text(_data.model!.temperature!.toStringAsFixed(1) + '\u00b0C',
                  style: Theme.of(context).textTheme.headline3),
              Text('Feels Like : ' '${_data.model!.feelsLike}' '\u00b0C',
                  style: Theme.of(context).textTheme.caption),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_data.model!.weatherMain ?? '',
                      style: Theme.of(context).textTheme.bodyText1),
                  Text(_data.model!.weatherDescription ?? '',
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
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

  @override
  bool get wantKeepAlive => true;
}
