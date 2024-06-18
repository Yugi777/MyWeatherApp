import 'package:flutter/material.dart';
import 'package:myapp/models/weather_model.dart';
import 'package:myapp/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('fed7f6bd81dd7c294dcf078fcf4feb04');
  Weather? _weather;

  _fetchWeather(String cityName) async {
    final weather = await _weatherService.getWeather(cityName);
    setState(() {
      _weather = weather;
    });
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/windy.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/windy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/cloudy.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/windy.json'; // Add default case
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 20),
              child: Column(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey[700],
                    size: 36,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _weather?.cityName.toUpperCase() ?? "LOADING CITY...",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 18,
                      fontFamily: 'Oswald',
                    ),
                  ),
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: Lottie.asset(
                getWeatherAnimation(_weather?.mainCondition),
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 80),
              child: Text(
                '${_weather?.temperature.round()}°',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 48,
                  fontFamily: 'Oswald',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                style: TextStyle(color: Colors.grey[700]),
                textAlign: TextAlign.center,
                onSubmitted: _fetchWeather,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
