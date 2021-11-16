import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/data/local/localstorage.dart';
import 'package:weatherapp/data/remote/json_to_model.dart';

class Api {
  final String? cityName;
  Api({this.cityName});
  static String? apiKey = dotenv.get('API_KEY');

  Stream<Map<String, dynamic>> searchWeatherData() async* {
    Uri _search = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');
    yield {'status': 'loading'};
    try {
      http.Response _response = await http.get(_search);
      if (_response.statusCode != 200) {
        yield {'status': 'bad-request'};
      } else {
        Map<String, dynamic> _body = jsonDecode(_response.body);
        print('called');
        yield {'status': 'success', 'value': _body};
      }
    } on SocketException {
      yield {'status': 'socket-error'};
    } catch (e) {
      print(e);
      yield {'status': 'unknown-request'};
    }
  }
}
