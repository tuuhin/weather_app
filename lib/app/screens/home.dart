import 'package:flutter/material.dart';
import 'package:weatherapp/app/screens/home/hourlydata.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [HourlyData()],
        ),
      ),
    ));
  }
}
