import 'package:flutter/material.dart';
import 'package:weather_app/home/repositories/weather_repository.dart';
import 'package:weather_app/home/models/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  Weather? _weather;
  bool _isLoading = false;
  bool _cityEntered = false;

  @override
  void initState() {
    super.initState();
    _weather = null;
  }

  void _fetchWeather(String city) {
    setState(() {
      _isLoading = true;
    });

    WeatherRepository().getWeather(city).then(
      (weather) {
        setState(() {
          _weather = weather;
          _isLoading = false;
          _cityEntered = true;
        });
      },
    ).catchError((error) {
      setState(() {
        _isLoading = false;
        _cityEntered = true;
      });
      _showErrorSnackBar(city);
    });
  }

  void _showErrorSnackBar(String city) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Stadt nicht gefunden: $city'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: const Text('Weather Button'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  hintText: 'Enter a city name',
                ),
                onTap: () {
                  _cityController.clear();
                },
                onSubmitted: (value) {
                  _fetchWeather(value);
                },
              ),
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_weather != null)
                Column(
                  children: [
                    Text(
                      _cityController.text,
                      style: const TextStyle(fontSize: 22),
                    ),
                    Text(
                      '${_weather!.temperature}°C',
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                    Text(
                      'min.: ${_weather!.minTemperature}°C',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      'max.: ${_weather!.maxTemperature}°C',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                )
              else if (_cityEntered) // Nur anzeigen, wenn eine Stadt eingegeben wurde
                Text(
                  'Stadt nicht gefunden: ${_cityController.text}',
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}
