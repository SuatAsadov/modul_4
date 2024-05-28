
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';



final weatherProvider = FutureProvider.family<Weather, List<double>>((ref, coordinates) async {
  final weatherService = WeatherService();
  return weatherService.fetchWeather(coordinates[0], coordinates[1]);
});

