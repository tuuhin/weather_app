import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    DataProviderCubit _data = BlocProvider.of<DataProviderCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: FutureBuilder(
                    future: Utils.locationFromCoordinate(
                        _data.model!.lattitude, _data.model!.longitude),
                    builder: (context, AsyncSnapshot<String?> snapshot) {
                      return Text(snapshot.data ?? '',
                          style: Theme.of(context).textTheme.headline6);
                    }),
              ),
              Text(_data.model!.temperature!.toStringAsFixed(1) + ' \u00b0C',
                  style: Theme.of(context).textTheme.headline3),
              Text('Feels like : ' '${_data.model!.feelsLike}' '\u00b0C',
                  style: Theme.of(context).textTheme.caption),
            ],
          ),
          Column(
            children: [
              _data.model!.weatherIconId != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 3),
                      child: Image.asset(
                        'assets/icon/${_data.model!.weatherIconId}.png',
                      ),
                    )
                  : const SizedBox.shrink(),
              Text(_data.model!.weatherMain ?? '',
                  style: Theme.of(context).textTheme.bodyText1),
              Text(_data.model!.weatherDescription ?? '',
                  style: Theme.of(context).textTheme.caption),
            ],
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
