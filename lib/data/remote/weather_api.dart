import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/data/remote/json_to_model.dart';

class Api {
  final String? cityName;
  Api({this.cityName});
  static String? apiKey = dotenv.get('API_KEY');

  static Stream getFavouritesWeather(List<String> cities) async* {
    //current weather data of the favourites
    List<Map<String, dynamic>> _data = [];
    yield {'status': 'loading'};
    for (String city in cities) {
      try {
        http.Response _res = await http.get(Uri.parse(
            'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));
        if (_res.statusCode == 200) {
          // if status_code is 200 then appending the data
          _data.add(jsonDecode(_res.body) as Map<String, dynamic>);
        } else if (_res.statusCode == 404) {
          yield {'status': 'bad-request'};
        }
      } on SocketException catch (e) {
        //internet-check
        yield {'status': 'internet-absent', 'value': e};
        break;
      } on TimeoutException catch (e) {
        // failed to response on time
        yield {'status': 'time-out', 'value': e};
        break;
      } catch (e) {
        // a unknown error
        print(e.toString());
        yield {'status': 'unknown', 'value': e};
        break;
      }
    }
    if (_data.isNotEmpty) {
      yield {
        'status': 'success',
        'value': _data.map((e) => JsonToModel.toCard(e)).toList()
      };
    }
  }

  static Stream<Map<String, dynamic>> searchWeatherData(
      String cityName) async* {
    //current weather data from lattitude and longitude
    Uri _search = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');

    try {
      yield {'status': 'loading'};
      http.Response _response = await http.get(_search);
      // checking for the type of responses
      // if 200 then its valid otherwise its not

      if (_response.statusCode == 404) {
        yield {
          'status': 'bad-request',
          'value': jsonDecode(_response.body) as Map<String, dynamic>
        };
      } else if (_response.statusCode == 200) {
        yield {
          'status': 'success',
          'value': jsonDecode(_response.body) as Map<String, dynamic>
        };
      }
    } on SocketException catch (e) {
      //checking for the internet
      yield {'status': 'internet-absent', 'value': e};
    } on TimeoutException catch (e) {
      //checking for the timeout
      yield {'status': 'time-out', 'value': e};
    } catch (e) {
      //checking for other type of errors
      print(e.toString());
      yield {'status': 'unknown', 'value': e};
    }
  }

  static Stream<Map<String, dynamic>> currentPosWeather(
      double latt, double long) async* {
    //current weatherdata from lattitude and longitude
    Uri _search = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latt&lon=$long&appid=$apiKey&units=metric');

    try {
      yield {'status': 'loading'};
      http.Response _response = await http.get(_search);
      //checking for the status if
      // ites a valid request or not

      if (_response.statusCode == 400) {
        yield {
          'status': 'bad-request',
          'value': jsonDecode(_response.body) as Map<String, dynamic>
        };
      }
      if (_response.statusCode == 200) {
        yield {
          'status': 'success',
          'value': jsonDecode(_response.body) as Map<String, dynamic>
        };
      }
    } on SocketException catch (e) {
      //checking for the internet
      yield {'status': 'intenet-absent', 'value': e};
    } on TimeoutException catch (e) {
      //checking for the timeout
      yield {'status': 'time-out', 'value': e};
    } catch (e) {
      //checking for other type of errors
      print(e.toString());
      yield {'status': 'unknown', 'value': e};
    }
  }

  static Stream<Map<String, dynamic>> getBulkData(num latt, num long) async* {
    Uri _url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/onecall?lat=$latt&lon=$long&exclude=minutely,alerts&appid=$apiKey&units=metric');
    try {
      yield {'status': 'loading'};
      http.Response _response = await http.get(_url);
      //checking for the status if
      // ites a valid request or not
      if (_response.statusCode == 200) {
        yield {
          'status': 'success',
          'value': jsonDecode(_response.body) as Map<String, dynamic>
        };
      } else {
        yield {
          'status': 'bad-request',
          'value': jsonDecode(_response.body) as Map<String, dynamic>
        };
      }
    } on SocketException catch (e) {
      //checking for the internet
      yield {'status': 'internet-absent', 'value': e};
    } catch (e) {
      //checking for other type of errors
      print(e.toString());
      yield {'status': 'unknown', 'value': e};
    }
  }
}
