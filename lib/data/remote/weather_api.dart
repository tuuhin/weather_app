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
    List<Map<String, dynamic>> _data = [];
    yield {'status': 'loading'};
    for (String city in cities) {
      try {
        http.Response _res = await http.get(Uri.parse(
            'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));
        if (_res.statusCode == 200) {
          Map<String, dynamic> _body = jsonDecode(_res.body);

          _data.add(_body);
        } else {
          yield {'status': 'bad-request'};
        }
      } on SocketException {
        yield {'status': 'socket-error'};
        break;
      } catch (e) {
        print(e.toString());
        yield {'status': 'unknown-request'};
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
    Uri _search = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    yield {'status': 'loading'};
    try {
      http.Response _response = await http.get(_search);
      if (_response.statusCode != 200) {
        yield {'status': 'bad-request'};
      } else {
        Map<String, dynamic> _body = jsonDecode(_response.body);
        // print('callled api');
        yield {'status': 'success', 'value': _body};
      }
    } on SocketException {
      yield {'status': 'socket-error'};
    } catch (e) {
      print(e.toString());
      yield {'status': 'unknown-request'};
    }
  }

  static Stream<Map<String, dynamic>> currentPosWeather(
      double latt, double long) async* {
    print(latt);
    Uri _search = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latt&lon=$long&appid=$apiKey&units=metric');
    yield {'status': 'loading'};
    try {
      http.Response _response = await http.get(_search);

      if (_response.statusCode != 200) {
        print(_response.body);
        yield {'status': 'bad-request'};
      } else {
        Map<String, dynamic> _body = jsonDecode(_response.body);
        // print('callled api');
        yield {'status': 'success', 'value': _body};
      }
    } on SocketException {
      yield {'status': 'socket-error'};
    } catch (e) {
      print(e.toString());
      yield {'status': 'unknown-request'};
    }
  }
}
