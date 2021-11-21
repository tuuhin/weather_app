import 'package:flutter/material.dart';
import 'package:weatherapp/app/screens/home/home.dart';

class HourlyData extends StatelessWidget {
  const HourlyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hourly Data',
          style: Theme.of(context).textTheme.headline6,
        ),
        HourTile(
          temp: 20,
          time: DateTime.now(),
        )
      ],
    );
  }
}
