class SummaryModel {
  num? lon;
  num? lat;
  String? weatherId;
  String? weatherMain;
  String? description;
  num? temp;
  num? maxTemp;
  num? minTemp;
  num? pressure;
  num? humidity;
  num? visibility;
  num? windSpeed;
  num? clouds;
  String? cityName;
  SummaryModel(
      {this.cityName,
      this.clouds,
      this.windSpeed,
      this.visibility,
      this.humidity,
      this.pressure,
      this.minTemp,
      this.maxTemp,
      this.temp,
      this.description,
      this.weatherMain,
      this.lat,
      this.weatherId,
      this.lon});
}
