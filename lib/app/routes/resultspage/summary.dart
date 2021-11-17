import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              Text('${summaryModel!.cityName}',
                  style: Theme.of(context).textTheme.headline4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('lat: ${summaryModel!.lat}',
                      style: Theme.of(context).textTheme.caption),
                  const VerticalDivider(),
                  Text('lon: ${summaryModel!.lon}',
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
              Chip(
                  label: Text('${summaryModel!.weatherMain}',
                      style: Theme.of(context).textTheme.headline6)),
              Text('${summaryModel!.temp} ' '\u00b0C',
                  style: Theme.of(context).textTheme.headline3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Chip(
                      avatar: FaIcon(FontAwesomeIcons.wind),
                      label: Text('${summaryModel!.windSpeed} m/s')),
                  Chip(
                      avatar: Icon(Icons.drive_file_move_sharp),
                      label: Text('${summaryModel!.humidity} %')),
                  Chip(
                      avatar: Icon(Icons.present_to_all_outlined),
                      label: Text('${summaryModel!.pressure} atm'))
                ],
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, i) => ListTile(
                          contentPadding: EdgeInsets.zero,
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
