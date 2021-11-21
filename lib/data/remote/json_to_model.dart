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
}
