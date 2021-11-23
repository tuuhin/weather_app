import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/data/utlis.dart';
import 'package:weatherapp/domain/models/models.dart';

class HourDetails extends StatelessWidget {
  final List<HourModel>? hourlyData;
  const HourDetails({Key? key, this.hourlyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(hourlyData!.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hour Details'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 60),
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LineChart(
                LineChartData(
                    minX: 0,
                    minY: 0,
                    maxX: hourlyData!.length.toDouble() - 1,
                    maxY: 50,
                    titlesData: FlTitlesData(
                      show: true,
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, t) =>
                            Theme.of(context).textTheme.caption,
                      ),
                      topTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, t) =>
                            Theme.of(context).textTheme.caption,
                        getTitles: (t) {
                          return Utils.timeStamp24hr(
                                  hourlyData![t.toInt()].unixTimeStamp ?? 0)
                              .toString();
                        },
                      ),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, t) =>
                            Theme.of(context).textTheme.caption,
                        getTitles: (double d) {
                          return hourlyData![d.toInt()].windSpeed.toString();
                        },
                      ),
                      rightTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, t) =>
                            Theme.of(context).textTheme.caption,
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    axisTitleData: FlAxisTitleData(
                        show: false,
                        leftTitle: AxisTitle(
                            titleText: 'Temperature', showTitle: true),
                        bottomTitle: AxisTitle(
                            titleText: 'Timings', margin: 10, showTitle: true)),
                    lineBarsData: [
                      LineChartBarData(
                          dotData: FlDotData(
                              show: false,
                              checkToShowDot: (spot, barData) => true),
                          spots: hourlyData!
                              .asMap()
                              .map(
                                (key, value) => MapEntry(
                                  key,
                                  FlSpot(
                                    key.toDouble(),
                                    value.temp!.toDouble(),
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                          isCurved: true,
                          colors:
                              Theme.of(context).brightness == Brightness.light
                                  ? [Colors.orange, Colors.pink]
                                  : [Colors.blue, Colors.purple])
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
