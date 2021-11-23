class HourModel {
  final int? unixTimeStamp;
  final num? temp;
  final String? weatherIconId;
  final num? pop;
  final num? windSpeed;

  const HourModel({
    this.windSpeed,
    this.pop,
    this.unixTimeStamp,
    this.weatherIconId,
    this.temp,
  });
}
