import 'package:weatherapp/domain/models/favourites_model.dart';
import 'package:weatherapp/domain/models/models.dart';

class JsonToModel {
  static SummaryModel toSummary(Map<String, dynamic> data) {
    return SummaryModel(
        cityName: data['name'],
        clouds: data['clouds']['all'],
        windSpeed: data['wind']['speed'],
        visibility: data['visibility'],
        humidity: data['main']['humidity'],
        pressure: data['main']['pressure'],
        minTemp: data['main']['temp_min'],
        maxTemp: data['main']['temp_max'],
        temp: data['main']['temp'],
        weatherMain: data['weather'][0]['main'],
        description: data['weather'][0]['description'],
        weatherId: data['weather'][0]['icon'],
        lat: data['coord']['lat'],
        lon: data['coord']['lon']);
  }

  static FavouriteModel toCard(Map<String, dynamic> data) {
    return FavouriteModel(
      cityname: data['name'],
      windSpeed: data['wind']['speed'],
      visibility: data['visibility'],
      humidity: data['main']['humidity'],
      pressure: data['main']['pressure'],
      temp: data['main']['temp'],
    );
  }

  static HomeModel getModel(Map<String, dynamic> data) {
    List hourdata = data['hourly'];
    List dayData = data['daily'];
    return HomeModel(
        weatherIconId: data['current']['weather'][0]['icon'],
        weatherMain: data['current']['weather'][0]['main'],
        place: data['timezone'],
        windSpeed: data['current']['wind_speed'],
        pressure: data['current']['pressure'],
        humidity: data['current']['humidity'],
        temperature: data['current']['temp'],
        sunriseUnixTimeStamp: data['current']['sunrise'],
        sunsetUnixTimeStamp: data['current']['sunset'],
        hourData: hourdata
            .map(
              (hour) => HourModel(
                  pop: hour['pop'] * 100,
                  windSpeed: hour['wind_speed'],
                  weatherIconId: hour['weather'][0]['icon'],
                  unixTimeStamp: hour['dt'],
                  temp: hour['temp']),
            )
            .toList(),
        dailyData: dayData
            .map(
              (day) => DayModel(
                  pop: day['pop'],
                  windSpeed: day['wind_speed'],
                  weatherIconId: day['weather'][0]['icon'],
                  unixTimeStamp: day['dt'],
                  maxTemp: day['temp']['max'],
                  minTemp: day['temp']['min']),
            )
            .toList());
  }
}
