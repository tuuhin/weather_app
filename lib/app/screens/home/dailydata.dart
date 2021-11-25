import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/routes/daydetails/weekdetails.dart';
import 'package:weatherapp/app/screens/home/dailydatatile.dart';
import 'package:weatherapp/domain/utlis.dart';
import 'package:weatherapp/domain/services/cubit/DataProvider/dataprovider_cubit.dart';

class DailyData extends StatelessWidget {
  const DailyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataproviderCubit _data = BlocProvider.of<DataproviderCubit>(context);
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WeekDetails(day: _data.model!.dailyData)));
          },
          dense: true,
          title:
              Text('Week Report', style: Theme.of(context).textTheme.subtitle2),
          trailing:
              Text('More Details', style: Theme.of(context).textTheme.caption),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _data.model!.dailyData != null
              ? SingleChildScrollView(
                  child: Column(
                      children: _data.model!.dailyData!
                          .map((day) => DailyDataTile(
                                day: Utils.readDay(day.unixTimeStamp ?? 0),
                                maxTemp: day.maxTemp,
                                minTemp: day.minTemp,
                                weatherIcon: day.weatherIconId,
                              ))
                          .toList()),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
