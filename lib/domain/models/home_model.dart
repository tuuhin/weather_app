import 'package:weatherapp/domain/models/models.dart';

class HomeModel {
  final double? lattitude;
  final double? longitude;
  final String? weatherIconId;
  final num? feelsLike;
  final String? weatherMain;
  final String? weatherDescription;

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
      this.feelsLike,
      this.weatherDescription,
      this.lattitude,
      this.longitude,
      this.weatherMain,
      this.windSpeed,
      this.pressure,
      this.humidity,
      this.temperature,
      this.sunriseUnixTimeStamp,
      this.sunsetUnixTimeStamp,
      this.hourData,
      this.dailyData});
}
