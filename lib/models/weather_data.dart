class WeatherData {
  final double temperature; // In Celsius
  final int humidity; // Percentage
  final String weatherCondition;
  final String weatherDescription;
  final double windSpeed; // m/s
  final int cloudiness; // percentage

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.weatherCondition,
    required this.weatherDescription,
    required this.windSpeed,
    required this.cloudiness,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['main']['temp']?.toDouble() ?? 0.0,
      humidity: json['main']['humidity'] ?? 0,
      weatherCondition: json['weather'][0]['main'] ?? 'Unknown',
      weatherDescription: json['weather'][0]['description'] ?? 'unknown',
      windSpeed: json['wind']['speed']?.toDouble() ?? 0.0,
      cloudiness: json['clouds']['all'] ?? 0,
    );
  }
}
