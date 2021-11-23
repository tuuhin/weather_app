import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/data/utlis.dart';
import 'package:weatherapp/domain/models/day_model.dart';
import 'dart:math';

class WeekDetails extends StatelessWidget {
  final List<DayModel>? day;
  const WeekDetails({Key? key, this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChart(
                  LineChartData(
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: SideTitles(
                          showTitles: true,
                          margin: 10,
                          getTextStyles: (context, t) =>
                              Theme.of(context).textTheme.caption,
                          getTitles: (double d) {
                            return '${d.toInt()}' '\u00b0C';
                          },
                        ),
                        topTitles: SideTitles(
                          margin: 20,
                          showTitles: true,
                          getTextStyles: (context, t) =>
                              Theme.of(context).textTheme.caption,
                          getTitles: (t) {
                            return Utils.timestamptoDate(
                                    day![t.toInt()].unixTimeStamp ?? 0)
                                .toString();
                          },
                        ),
                        bottomTitles: SideTitles(
                          showTitles: true,
                          margin: 10,
                          getTextStyles: (context, t) =>
                              Theme.of(context).textTheme.caption,
                          getTitles: (double d) {
                            return '${day![d.toInt()].windSpeed!}';
                          },
                        ),
                        rightTitles: SideTitles(
                          showTitles: true,
                          margin: 10,
                          getTextStyles: (context, t) =>
                              Theme.of(context).textTheme.caption,
                          getTitles: (double d) {
                            return '${d.toInt()}%';
                          },
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      axisTitleData: FlAxisTitleData(
                          show: true,
                          topTitle: AxisTitle(
                              titleText: 'Dates (in /mm/dd )', showTitle: true),
                          rightTitle: AxisTitle(
                              titleText: 'Percentage of precipitaion',
                              showTitle: true),
                          leftTitle: AxisTitle(
                              titleText: 'Temperature', showTitle: true),
                          bottomTitle: AxisTitle(
                              titleText: 'WInd Speed (in m/s)',
                              margin: 10,
                              showTitle: true)),
                      lineBarsData: [
                        LineChartBarData(
                            dotData: FlDotData(
                                show: false,
                                checkToShowDot: (spot, barData) => true),
                            spots: day!
                                .asMap()
                                .map(
                                  (key, value) => MapEntry(
                                    key,
                                    FlSpot(
                                      key.toDouble(),
                                      value.maxTemp!.toDouble(),
                                    ),
                                  ),
                                )
                                .values
                                .toList(),
                            isCurved: true,
                            colors:
                                Theme.of(context).brightness == Brightness.light
                                    ? [Colors.deepOrange]
                                    : [Colors.deepPurple]),
                        LineChartBarData(
                            dotData: FlDotData(
                                show: false,
                                checkToShowDot: (spot, barData) => true),
                            spots: day!
                                .asMap()
                                .map(
                                  (key, value) => MapEntry(
                                    key,
                                    FlSpot(
                                      key.toDouble(),
                                      value.minTemp!.toDouble(),
                                    ),
                                  ),
                                )
                                .values
                                .toList(),
                            isCurved: true,
                            colors:
                                Theme.of(context).brightness == Brightness.light
                                    ? [Colors.orange]
                                    : [Colors.purple]),
                        LineChartBarData(
                            dotData: FlDotData(
                                show: false,
                                checkToShowDot: (spot, barData) => true),
                            spots: day!
                                .asMap()
                                .map(
                                  (key, value) => MapEntry(
                                    key,
                                    FlSpot(
                                      key.toDouble(),
                                      value.windSpeed!.toDouble(),
                                    ),
                                  ),
                                )
                                .values
                                .toList(),
                            isCurved: true,
                            colors:
                                Theme.of(context).brightness == Brightness.light
                                    ? [Colors.blueGrey]
                                    : [Colors.blueAccent]),
                        LineChartBarData(
                            dotData: FlDotData(
                                show: false,
                                checkToShowDot: (spot, barData) => true),
                            spots: day!
                                .asMap()
                                .map(
                                  (key, value) => MapEntry(
                                    key,
                                    FlSpot(
                                      key.toDouble(),
                                      value.pop!.toDouble() * 100,
                                    ),
                                  ),
                                )
                                .values
                                .toList(),
                            isCurved: true,
                            colors: [Colors.grey])
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
