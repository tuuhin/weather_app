import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String? cityname;
  final num? temp;
  final num? windSpeed;
  final num? humidity;
  final num? pressure;
  final num? visibility;

  const WeatherCard(
      {Key? key,
      this.cityname,
      this.temp,
      this.windSpeed,
      this.humidity,
      this.pressure,
      this.visibility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  cityname ?? '',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Text(
                '$temp',
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
          subtitle: Container(
            height: 65,
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[100]
                    : Colors.white10),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.orange
                          : Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.orange
                                  : Colors.blue,
                          blurRadius: 5,
                        )
                      ]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Wind Speed : $windSpeed'),
                          Text('Humidity : $humidity')
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pressure : $pressure'),
                          Text('Visibility : $visibility')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
