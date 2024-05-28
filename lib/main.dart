// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/weather_provider.dart';
import 'models/weather.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends ConsumerWidget {
  final double latitude = 37.7749; // Örnek Latitude
  final double longitude = -122.4194; // Örnek Longitude

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsyncValue = ref.watch(weatherProvider([latitude, longitude]));

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: weatherAsyncValue.when(
          data: (weather) => WeatherDisplay(weather: weather),
          loading: () => CircularProgressIndicator(),
          error: (err, stack) {
            print('Error: $err');
            return Text('Failed to load weather: $err');
          },
        ),
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  const WeatherDisplay({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Location: ${weather.location}'),
        Text('Temperature: ${weather.temperature} °C'),
        Text('Condition: ${weather.condition}'),
      ],
    );
  }
}
