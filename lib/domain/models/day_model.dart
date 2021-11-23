class DayModel {
  final int? unixTimeStamp;
  final num? maxTemp;
  final num? minTemp;
  final String? weatherIconId;
  final num? pop;
  final num? windSpeed;
  DayModel({
    this.windSpeed,
    this.pop,
    this.unixTimeStamp,
    this.maxTemp,
    this.minTemp,
    this.weatherIconId,
  });
}
