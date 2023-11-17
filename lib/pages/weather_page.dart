import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/Sunny.json";

    switch (mainCondition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/Cloudy.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/Rainy.json";
      case "thunderstorm":
        return "assets/Thunderstorm.json";
      case "clear":
        return "assets/Sunny.json";
      default:
        return "assets/Sunny.json";
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
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //show city name
            Column(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 30.0,
                ),
                Text(
                  _weather?.cityName.toUpperCase() ??
                      "Loading...".toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
              ],
            ),

            //Show Weather Animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //show temperature
            Text(
              "${_weather?.temperature.round() ?? "~"}°C",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
