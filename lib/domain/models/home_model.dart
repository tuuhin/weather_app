import 'package:weatherapp/domain/models/models.dart';

class HomeModel {
  final String? weatherIconId;
  final String? weatherMain;
  final String? place;
  final num? windSpeed;
  final num? pressure;
  final num? humidity;
  final num? temperature;
  final int? sunriseUnixTimeStamp;
  final int? sunsetUnixTimeStamp;
  final List<HourModel>? hourData;
  final List<DayModel>? dailyData;

  HomeModel(
      {this.weatherIconId,
      this.weatherMain,
      this.place,
      this.windSpeed,
      this.pressure,
      this.humidity,
      this.temperature,
      this.sunriseUnixTimeStamp,
      this.sunsetUnixTimeStamp,
      this.hourData,
      this.dailyData});
}
