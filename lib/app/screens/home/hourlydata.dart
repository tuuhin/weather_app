import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/screens/home/home.dart';
import 'package:weatherapp/domain/utlis.dart';
import 'package:weatherapp/domain/services/cubit/DataProvider/dataprovider_cubit.dart';

class HourlyData extends StatelessWidget {
  const HourlyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataproviderCubit _data = BlocProvider.of<DataproviderCubit>(context);

    return Column(
      children: [
        ListTile(
          dense: true,
          title:
              Text('Day Report', style: Theme.of(context).textTheme.subtitle2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: (_data.model!.hourData != null)
                  ? _data.model!.hourData!
                      .map((hour) => HourTile(
                            temp: hour.temp,
                            iconCode: hour.weatherIconId,
                            time: Utils.readTimeStamp(hour.unixTimeStamp ?? 0),
                          ))
                      .toList()
                  : [],
            ),
          ),
        ),
      ],
    );
  }
}
