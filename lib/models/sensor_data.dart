class SensorData {
  final double temperature;
  final int humidityAir;
  final int humiditySoil;
  final int rainForecast;

  SensorData({
    required this.temperature,
    required this.humidityAir,
    required this.humiditySoil,
    required this.rainForecast,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      temperature: (json['temperature'] ?? 0).toDouble(),
      humidityAir: json['humidity_air'] ?? 0,
      humiditySoil: json['humidity_soil'] ?? 0,
      rainForecast: json['rain_forecast'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'humidity_air': humidityAir,
      'humidity_soil': humiditySoil,
      'rain_forecast': rainForecast,
    };
  }
}
