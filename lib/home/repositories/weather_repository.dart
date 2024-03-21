// ignore_for_file: avoid_print

/* -------------------------------------------------------------------------- */
/*               //SECTION - für die API-Kommunikation via getWeather()       */
/*                           mit JSON, HTTP-Package                           */
/* -------------------------------------------------------------------------- */

import 'package:http/http.dart' as http;
import 'package:weather_app/home/models/weather.dart';
import 'dart:convert';

/* - Mein Api-Key @ Api Ninjas com wgvhYbrYetmOl6EoCPSdfsGid0zbxlmLjHJJh7Fr - */

class WeatherRepository {
  static const _apiKey = 'wgvhYbrYetmOl6EoCPSdfsGid0zbxlmLjHJJh7Fr';
  Future<Weather?> getWeather(String city) async {
    final url = 'https://api.api-ninjas.com/v1/weather?city=$city';
    try {
      final response =
          await http.get(Uri.parse(url), headers: {'X-Api-Key': _apiKey});
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Weather.fromJson(jsonData);
      } else {
        // Stadt nicht gefunden, daher geben wir null zurück
        print('Stadt nicht gefunden: $city - ${response.body}');
        return null;
      }
    } catch (e) {
      // Fehler beim Laden der Wetterdaten, daher geben wir null zurück
      print('Fehler beim Laden des Wetters: $e');
      return null;
    }
  }
}
