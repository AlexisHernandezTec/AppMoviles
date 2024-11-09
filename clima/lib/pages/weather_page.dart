import 'package:clima/models/weather_model.dart';
import 'package:clima/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('090c0afb3817ddecf1f1b325b6ecb6f5');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null) return 'assets/sun.json';
    switch(mainCondition) {
      case 'clear':
        return 'assets/sun.json';
      case 'clouds':
        return 'assets/cloud.json';
      case 'rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      default:
        return 'assets/sun.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(_weather?.cityName ?? 'Loading...'),
        Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
        Text('Temperature: ${_weather?.temperature.round().toString()}°C'),
        Text(_weather?.mainCondition ?? ""),
      ],),
    );
  }
}