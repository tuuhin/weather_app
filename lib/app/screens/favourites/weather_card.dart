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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$cityname', style: Theme.of(context).textTheme.headline5),
            Text('$temp' '\u00b0C',
                style: Theme.of(context).textTheme.headline4)
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 65,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.amber[100]
                    : Colors.white10),
            child: Row(
              children: [
                Container(
                  width: 6,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.82,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Wind Speed : $windSpeed m/s'),
                          Text('Humidity : $humidity %')
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pressure : $pressure atm'),
                          Text('Visibility : $visibility m')
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
