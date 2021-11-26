class DayModel {
  final int? unixTimeStamp;
  final num? maxTemp;
  final num? minTemp;
  final String? weatherIconId;
  final num? pop;
  final num? windSpeed;

  final String? weatherMain;
  final String? weatherDescription;
  final int? sunrise;
  final int? sunset;
  final num? tempFeelsLike;
  final num? pressure;
  final num? humidity;
  final num? dewPoint;

  final num? uvi;
  final num? rain;
  DayModel({
    this.windSpeed,
    this.weatherMain,
    this.weatherDescription,
    this.sunrise,
    this.sunset,
    this.tempFeelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.rain,
    this.pop,
    this.unixTimeStamp,
    this.maxTemp,
    this.minTemp,
    this.weatherIconId,
  });
}
