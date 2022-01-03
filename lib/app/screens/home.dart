import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/app/screens/home/home.dart';
import 'package:weatherapp/domain/services/cubit/AppCubit/app_cubit.dart';
import 'package:weatherapp/domain/services/cubit/TimeFormatCubit/timeformat_cubit.dart';
import 'package:weatherapp/domain/utlis.dart';
import 'package:weatherapp/domain/services/cubit/DataProvider/dataprovider_cubit.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProviderCubit _data = BlocProvider.of<DataProviderCubit>(context);
    TimeFormatCubit _timeFormat =
        BlocProvider.of<TimeFormatCubit>(context, listen: true);
    AppCubit _app = BlocProvider.of<AppCubit>(context);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: Text('Refresh ',
                          style: Theme.of(context).textTheme.headline6),
                      content: Text('Refresh the dataset by reloading the app',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 14,
                              fontFamily:
                                  GoogleFonts.robotoCondensed().fontFamily)),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _app.emitLoader();
                            },
                            child: Text('Refresh',
                                style: Theme.of(context).textTheme.subtitle2))
                      ],
                    ));
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const CurrentWeather(),
              const BasicWeatherData(),
              Sunrise(
                sunset: Utils.readTimeStamp(_timeFormat.is24Mode,
                    _data.model!.sunsetUnixTimeStamp ?? 0),
                sunrise: Utils.readTimeStamp(_timeFormat.is24Mode,
                    _data.model!.sunriseUnixTimeStamp ?? 0),
              ),
              const HourlyData(),
              const DailyData(),
            ],
          ),
        ),
      ),
    );
  }
}
