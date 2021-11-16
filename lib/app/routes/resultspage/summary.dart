import 'package:flutter/material.dart';
import 'package:weatherapp/app/routes/resultspage/results.dart';
import 'package:weatherapp/domain/models/models.dart';

class WeatherSummary extends StatelessWidget {
  final SummaryModel? summaryModel;
  const WeatherSummary({Key? key, this.summaryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<IconData> _icons = [
      Icons.ac_unit,
      Icons.ac_unit,
      Icons.ac_unit,
      Icons.ac_unit,
    ];
    final List<String> _heading = [
      'Max-Temp',
      'Min-Temp',
      'Cloud-Cover',
      'Visibility'
    ];
    final List<String> _data = [
      '${summaryModel!.maxTemp}',
      '${summaryModel!.minTemp}',
      '${summaryModel!.clouds}',
      '${summaryModel!.visibility}'
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FavouriteAppBar(cityname: summaryModel!.cityName),
              Text('${summaryModel!.temp}',
                  style: Theme.of(context).textTheme.headline3),
              Text('${summaryModel!.cityName}',
                  style: Theme.of(context).textTheme.headline4),
              Row(
                children: [
                  Text('lat: ${summaryModel!.lat}',
                      style: Theme.of(context).textTheme.caption),
                  Text('lon: ${summaryModel!.lon}',
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, i) => ListTile(
                          dense: true,
                          trailing: Text(_data[i]),
                          title: Text(_heading[i]),
                          leading: Icon(_icons[i]),
                        ),
                    separatorBuilder: (context, i) => const Divider(),
                    itemCount: _data.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
