/* -------------------------------------------------------------------------- */
/*                     //SECTION - Einstellungen, grundlegend f.d. App       */
/* ------------------------------------------------------------------------ */

import 'package:flutter/material.dart';
import 'package:weather_app/home/home_page.dart';

class WeatherAppChallenge extends StatelessWidget {
  const WeatherAppChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Farbpalette für die App
        scaffoldBackgroundColor:
            Colors.blueGrey[200], // Hintergrundfarbe der App
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey[400],
            title: const Text('Il Tempo senza Pulsante'),
          ),
          body: const HomePage()),
    );
  }
}
