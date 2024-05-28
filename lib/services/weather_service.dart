
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modul_4/constants.dart';
import 'package:modul_4/models/weather.dart';

class WeatherService {
  Future<Weather> fetchWeather(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('http://api.weatherapi.com/v1/current.json?key=$weatherApiKey&q=$latitude,$longitude&aqi=no')
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}

