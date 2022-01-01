import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/screens/home/home.dart';
import 'package:weatherapp/domain/services/cubit/TimeFormatCubit/timeformat_cubit.dart';
import 'package:weatherapp/domain/utlis.dart';
import 'package:weatherapp/domain/services/cubit/DataProvider/dataprovider_cubit.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataproviderCubit _data = BlocProvider.of<DataproviderCubit>(context);
    TimeFormatCubit _timeFormat =
        BlocProvider.of<TimeFormatCubit>(context, listen: true);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const CurrentWeather(),
            const BasicWeatherData(),
            Sunrise(
              sunset: Utils.readTimeStamp(
                  _timeFormat.is24Mode, _data.model!.sunsetUnixTimeStamp ?? 0),
              sunrise: Utils.readTimeStamp(
                  _timeFormat.is24Mode, _data.model!.sunriseUnixTimeStamp ?? 0),
            ),
            const HourlyData(),
            const DailyData(),
          ],
        ),
      ),
    );
  }
}
