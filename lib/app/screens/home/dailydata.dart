import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/app/routes/daydetails/weekdetails.dart';
import 'package:weatherapp/app/screens/home/dailydatatile.dart';
import 'package:weatherapp/domain/utlis.dart';
import 'package:weatherapp/domain/services/cubit/DataProvider/dataprovider_cubit.dart';

class DailyData extends StatelessWidget {
  const DailyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProviderCubit _data = BlocProvider.of<DataProviderCubit>(context);
    return Column(
      children: [
        const Divider(),
        Card(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      WeekDetails(day: _data.model!.dailyData)));
            },
            dense: true,
            title: Text('Week Weather Report',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontFamily: GoogleFonts.poppins().fontFamily)),
            trailing: Text('More Details',
                style: Theme.of(context).textTheme.caption),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _data.model!.dailyData != null
              ? Column(
                  children: _data.model!.dailyData!
                      .map((day) => DailyDataTile(
                            day: Utils.readDay(day.unixTimeStamp ?? 0),
                            maxTemp: day.maxTemp,
                            minTemp: day.minTemp,
                            weatherIcon: day.weatherIconId,
                          ))
                      .toList())
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
