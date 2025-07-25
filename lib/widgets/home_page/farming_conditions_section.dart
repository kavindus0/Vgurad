import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vguard/core/app_constants.dart';
import 'package:vguard/models/weather_data.dart';
import 'package:vguard/services/weather_service.dart';

class FarmingConditionsSection extends StatefulWidget {
  const FarmingConditionsSection({super.key});

  @override
  State<FarmingConditionsSection> createState() =>
      _FarmingConditionsSectionState();
}

class _FarmingConditionsSectionState extends State<FarmingConditionsSection> {
  final WeatherService _weatherService = WeatherService();
  late Future<WeatherData> _weatherFuture;
  final double _defaultLatitude = 6.9271; //Colombo, Sri Lanka
  final double _defaultLongitude = 79.8612; // Colombo, Sri Lanka

  @override
  void initState() {
    super.initState();

    // _fetchWeather();
    _getCurrentLocationAndFetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _weatherFuture = _weatherService.fetchWeatherData(
        _defaultLatitude,
        _defaultLongitude,
      );
    });
  }

  Future<void> _getCurrentLocationAndFetchWeather() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle error or show message
      print('Location services are disabled.');
      // Fallback to default location
      _fetchWeather();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle error
        print('Location permissions are denied.');
        _fetchWeather();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      _fetchWeather();
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      setState(() {
        _weatherFuture = _weatherService.fetchWeatherData(
          position.latitude,
          position.longitude,
        );
      });
    } catch (e) {
      print('Error getting location: $e');
      // Fallback to default location on error
      _fetchWeather();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge),
        padding: const EdgeInsets.all(AppSizes.paddingXLarge),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.grey100, AppColors.lightGreenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
          border: Border.all(color: AppColors.grey200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today\'s Farming Conditions',
                  style: AppTextStyles.sectionTitle,
                ),
                // For the 'Optimal' tag to show dynamic status
                FutureBuilder<WeatherData>(
                  future: _weatherFuture,
                  builder: (context, snapshot) {
                    String status = '...';
                    Color statusColor = AppColors.grey100;
                    if (snapshot.hasData) {
                      status = _weatherService.getOverallStatus(snapshot.data!);
                      if (status == 'Optimal') {
                        statusColor = AppColors.green;
                      } else if (status == 'Adverse') {
                        statusColor = AppColors.red;
                      } else {
                        statusColor = AppColors.orange; // Moderate
                      }
                    } else if (snapshot.hasError) {
                      status = 'Error';
                      statusColor = AppColors.red;
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingSmall + 4,
                        vertical: AppSizes.paddingSmall - 2,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [statusColor, statusColor.withOpacity(0.7)],
                        ),
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadiusLarge * 0.75,
                        ),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSizes.paddingXLarge),
            // FutureBuilder for the condition items
            FutureBuilder<WeatherData>(
              future: _weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: AppColors.primaryGreen,
                      size: 30,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to load weather: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  final weather = snapshot.data!;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ConditionItem(
                          icon: Icons.wb_sunny_outlined,
                          value: '${weather.temperature.toStringAsFixed(0)}°C',
                          label: 'Temperature',
                          iconColor: AppColors.amber,
                        ),
                      ),
                      Expanded(
                        child: ConditionItem(
                          icon: Icons.cloud_outlined,
                          value: '${weather.humidity}%',
                          label: 'Humidity',
                          iconColor: AppColors.blueGrey,
                        ),
                      ),
                      Expanded(
                        child: ConditionItem(
                          icon: Icons.trending_up,
                          value: _weatherService.getGrowthStatus(
                            weather,
                          ), // Dynamic growth
                          label: 'Growth',
                          iconColor: AppColors.green,
                        ),
                      ),
                      Expanded(
                        child: ConditionItem(
                          icon: Icons.shield_outlined,
                          value: _weatherService.getDiseaseRisk(
                            weather,
                          ), // Dynamic disease risk
                          label: 'Disease Risk',
                          iconColor: AppColors.deepOrange,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('No weather data available.'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ConditionItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const ConditionItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: AppSizes.iconSizeXXLarge, color: iconColor),
        const SizedBox(height: AppSizes.paddingSmall),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.black87,
          ),
        ),
        const SizedBox(height: AppSizes.borderRadiusSmall),
        Text(label, style: TextStyle(fontSize: 14, color: AppColors.grey600)),
      ],
    );
  }
}
