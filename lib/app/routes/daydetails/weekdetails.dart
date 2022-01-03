import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/routes/daydetails/daydetails.dart';
import 'package:weatherapp/domain/services/cubit/TimeFormatCubit/timeformat_cubit.dart';
import 'package:weatherapp/domain/utlis.dart';
import 'package:weatherapp/domain/models/day_model.dart';
import 'package:google_fonts/google_fonts.dart';

class WeekDetails extends StatefulWidget {
  final List<DayModel>? day;
  const WeekDetails({Key? key, this.day}) : super(key: key);

  @override
  State<WeekDetails> createState() => _WeekDetailsState();
}

class _WeekDetailsState extends State<WeekDetails> {
  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    TimeFormatCubit _timeFormat =
        BlocProvider.of<TimeFormatCubit>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Week\'s Weather',
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontFamily: GoogleFonts.workSans().fontFamily,
              fontWeight: FontWeight.w400),
        ),
      ),
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
                      lineTouchData: LineTouchData(enabled: false),
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
                                    widget.day![t.toInt()].unixTimeStamp ?? 0)
                                .toString();
                          },
                        ),
                        bottomTitles: SideTitles(
                          showTitles: true,
                          margin: 10,
                          getTextStyles: (context, t) =>
                              Theme.of(context).textTheme.caption,
                          getTitles: (double d) {
                            return '${widget.day![d.toInt()].windSpeed!}';
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
                          rightTitle: AxisTitle(
                              titleText: 'Percentage of precipitaion',
                              showTitle: true),
                          leftTitle: AxisTitle(
                              titleText: 'Temperature', showTitle: true),
                          bottomTitle: AxisTitle(
                              titleText: 'Wind Speed (in m/s)',
                              margin: 10,
                              showTitle: true)),
                      lineBarsData: [
                        LineChartBarData(
                            dotData: FlDotData(
                                show: false,
                                checkToShowDot: (spot, barData) => true),
                            spots: widget.day!
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
                            colors:
                                Theme.of(context).brightness == Brightness.light
                                    ? [Colors.deepOrange]
                                    : [Colors.deepPurple]),
                        LineChartBarData(
                            dotData: FlDotData(
                                show: false,
                                checkToShowDot: (spot, barData) => true),
                            spots: widget.day!
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
                            colors:
                                Theme.of(context).brightness == Brightness.light
                                    ? [Colors.orange]
                                    : [Colors.purple]),
                        LineChartBarData(
                            dotData: FlDotData(
                                show: false,
                                checkToShowDot: (spot, barData) => true),
                            spots: widget.day!
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
                            colors:
                                Theme.of(context).brightness == Brightness.light
                                    ? [Colors.blueGrey]
                                    : [Colors.blueAccent]),
                        LineChartBarData(
                            dotData: FlDotData(
                                show: false,
                                checkToShowDot: (spot, barData) => true),
                            spots: widget.day!
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
                            colors: [Colors.grey])
                      ]),
                ),
              ),
            ),
            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.day!.length,
                  itemBuilder: (context, i) => DetailsCard(
                        weatherMain: widget.day![i].weatherMain,
                        weatherDesc: widget.day![i].weatherDescription,
                        weatherIcon: widget.day![i].weatherIconId,
                        currentTemp: widget.day![i].tempFeelsLike,
                        windSpeed: widget.day![i].windSpeed,
                        uvi: widget.day![i].uvi,
                        dewpoint: widget.day![i].dewPoint,
                        precipitaion: widget.day![i].rain,
                        sunrise: Utils.readTimeStamp(
                            _timeFormat.is24Mode, widget.day![i].sunrise ?? 0),
                        sunset: Utils.readTimeStamp(
                            _timeFormat.is24Mode, widget.day![i].sunset ?? 0),
                        percentageOfPrecipitation: widget.day![i].pop,
                        pressure: widget.day![i].pressure,
                        humidity: widget.day![i].humidity,
                        date: Utils.showDateforDetails(
                            widget.day![i].unixTimeStamp ?? 0),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
