/* -------------------------------------------------------------------------- */
/*                //SECTION - Wetterdaten-Klasse                             */
/* ------------------------------------------------------------------------ */

class Weather {
  final double temperature;
  final double minTemperature;
  final double maxTemperature;

  Weather({
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['temp'].toDouble(),
      minTemperature: json['min_temp'].toDouble(),
      maxTemperature: json['max_temp'].toDouble(),
    );
  }
}
