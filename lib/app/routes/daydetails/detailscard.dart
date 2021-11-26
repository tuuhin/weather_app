import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  final String? date;
  final String? weatherMain;
  final String? weatherDesc;
  final String? weatherIcon;
  final num? currentTemp;
  final num? windSpeed;
  final num? percentageOfPrecipitation;
  final String? sunrise;
  final String? sunset;
  final num? uvi;
  final num? precipitaion;
  final num? dewpoint;
  final num? humidity;
  final num? pressure;
  const DetailsCard({
    Key? key,
    this.date,
    this.weatherMain,
    this.weatherDesc,
    this.weatherIcon,
    this.currentTemp,
    this.windSpeed,
    this.percentageOfPrecipitation,
    this.sunrise,
    this.sunset,
    this.uvi,
    this.precipitaion,
    this.dewpoint,
    this.humidity,
    this.pressure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(date ?? 'blank'),
            trailing: weatherIcon != null
                ? CachedNetworkImage(
                    width: 50,
                    height: 50,
                    errorWidget: (context, url, _) => const Icon(Icons.error),
                    placeholder: (context, str) =>
                        const SizedBox.square(dimension: 20),
                    imageUrl:
                        'http://openweathermap.org/img/wn/$weatherIcon@2x.png')
                : const SizedBox.square(dimension: 20),
            subtitle: Text.rich(TextSpan(
                text: '${weatherMain ?? 'blank'} / ',
                style: Theme.of(context).textTheme.bodyText2,
                children: [
                  TextSpan(
                      text: weatherDesc ?? 'blank',
                      style: Theme.of(context).textTheme.caption)
                ])),
          ),
          ListTile(
            dense: true,
            trailing: Text('${currentTemp ?? 0}' '\u00b0C'),
            title: const Text('Temperature'),
          ),
          ListTile(
            dense: true,
            trailing: Text('${humidity ?? 0} %'),
            title: const Text('Humidity'),
          ),
          ListTile(
            dense: true,
            trailing: Text('${windSpeed ?? 0} m/s'),
            title: const Text('Wind Speed'),
          ),
          ListTile(
            dense: true,
            trailing: Text(
                '${precipitaion ?? 'Unknown'} ${precipitaion != null ? 'mm' : ''}'),
            title: const Text('Rain'),
          ),
          ListTile(
            dense: true,
            trailing: Text('${pressure ?? 0} hPa'),
            title: const Text('Pressure'),
          ),
          ListTile(
            dense: true,
            trailing: Text('${percentageOfPrecipitation! * 100} '),
            title: const Text('Percentage of precipitaion'),
          ),
          ListTile(
            dense: true,
            trailing: Text('$dewpoint' '\u00b0C'),
            title: const Text('Dewpoint'),
          ),
          ListTile(
            dense: true,
            trailing: Text('$uvi '),
            title: const Text('UV Index'),
          ),
          ListTile(
            dense: true,
            trailing: Text('$sunrise '),
            title: const Text('Sunrise'),
          ),
          ListTile(
            dense: true,
            trailing: Text('$sunset'),
            title: const Text('Sunset'),
          ),
        ],
      ),
    );
  }
}
