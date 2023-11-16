import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //Set API Key
  final _weatherService = WeatherService("37649a631ba24307b0ee0ad2ee84e812");
  Weather? _weather;

  _fetchWeather() async {
    //get the current city name
    String cityName = await _weatherService.getCurrentCity();

    //get weather of the city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //initialize state
  @override
  void initState() {
    super.initState();
    //fetch weather
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //show city name
            Text(_weather?.cityName ?? "Loading..."),
      
            //show temperature
            Text("${_weather?.temperature.round()}°C"),
          ],
        ),
      ),
    );
  }
}
