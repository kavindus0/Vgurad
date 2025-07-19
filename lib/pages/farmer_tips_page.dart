import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';
import 'package:vguard/widgets/farmer_tips_page/category_chip.dart';
import 'package:vguard/widgets/farmer_tips_page/farming_tip_card.dart';
import 'package:vguard/widgets/farmer_tips_page/weather_alert_item.dart';

class FarmerTipsPage extends StatelessWidget {
  const FarmerTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkGreen,
        elevation: AppSizes.cardElevation,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/logo.png',
          height: 150,
          width: 150,
          fit: BoxFit.contain,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.lightGreenBackground,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingLarge,
              vertical: AppSizes.paddingMedium,
            ),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadiusMedium,
                      ),
                      side: BorderSide(color: AppColors.grey300),
                    ),
                    elevation: AppSizes.cardElevation,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingMedium,
                      vertical: AppSizes.paddingSmall + 4,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.horizontalSpacing),
                const Text(
                  'Farmer Tips & Advice',
                  style: AppTextStyles.pageHeaderTitle,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.paddingLarge),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Weather Alerts',
                        style: AppTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: AppSizes.paddingMedium),
                      Card(
                        elevation: AppSizes.cardElevation,
                        color: AppColors.yellowBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadiusMedium,
                          ),
                          side: BorderSide(color: AppColors.amber200),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSizes.paddingLarge),
                          child: Column(
                            children: [
                              WeatherAlertItem(
                                icon: Icons.cloud_outlined,
                                title: 'Heavy Rain Expected',
                                description:
                                    'Prepare drainage and avoid fertilizer application for next 3 days',
                                iconColor: AppColors.amber700,
                              ),
                              Divider(
                                height: AppSizes.paddingXXLarge,
                                thickness: AppSizes.dividerThickness,
                                color: AppColors.amber,
                              ),
                              WeatherAlertItem(
                                icon: Icons.wb_sunny_outlined,
                                title: 'Optimal Planting Weather',
                                description:
                                    'Current conditions are ideal for planting rice and vegetables',
                                iconColor: AppColors.amber700,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingXXLarge),

                      const Text(
                        'Filter by Category',
                        style: AppTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: AppSizes.paddingMedium),
                      Wrap(
                        spacing: AppSizes.paddingSmall + 2,
                        runSpacing: AppSizes.paddingSmall + 2,
                        children: const [
                          CategoryChip(label: 'All Tips', isSelected: true),
                          CategoryChip(label: 'Seasonal'),
                          CategoryChip(label: 'Weather'),
                          CategoryChip(label: 'Pest Management'),
                          CategoryChip(label: 'Harvest'),
                          CategoryChip(label: 'Soil Care'),
                        ],
                      ),
                      const SizedBox(height: AppSizes.paddingXXLarge),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount =
                              (constraints.maxWidth > 600) ? 2 : 1;
                          double childAspectRatio =
                              (constraints.maxWidth > 600) ? 1.0 : 1.0;

                          return GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: childAspectRatio,
                            mainAxisSpacing: AppSizes.verticalSpacing,
                            crossAxisSpacing: AppSizes.horizontalSpacing,
                            children: const [
                              FarmingTipCard(
                                title: 'Pre-Monsoon Preparation',
                                dateRange: 'April - May',
                                season: 'Pre-Monsoon',
                                tips: [
                                  'Clean and prepare drainage channels',
                                  'Check irrigation systems for proper functioning',
                                  'Apply organic matter to improve soil structure',
                                  'Plant cover crops to prevent soil erosion',
                                ],
                                tag: 'Seasonal',
                                tagColor: AppColors.teal,
                                icon: Icons.eco_outlined,
                              ),
                              FarmingTipCard(
                                title: 'Hot Weather Crop Care',
                                dateRange: 'March - June',
                                season: 'Summer',
                                tips: [
                                  'Water crops early morning or late evening',
                                  'Use mulching to retain soil moisture',
                                  'Provide shade nets for sensitive crops',
                                  'Monitor plants for heat stress symptoms',
                                ],
                                tag: 'Weather',
                                tagColor: AppColors.orange,
                                icon: Icons.wb_sunny_outlined,
                              ),
                              FarmingTipCard(
                                title: 'Pest Control During Monsoon',
                                dateRange: 'June - September',
                                season: 'Monsoon',
                                tips: [
                                  'Increase fungicide applications',
                                  'Remove standing water to prevent breeding',
                                  'Implement integrated pest management',
                                  'Use organic pesticides where possible',
                                ],
                                tag: 'Pest Management',
                                tagColor: AppColors.pink,
                                icon: Icons.bug_report_outlined,
                              ),
                              FarmingTipCard(
                                title: 'Post-Harvest Care',
                                dateRange: 'October - December',
                                season: 'Post-Harvest',
                                tips: [
                                  'Dry crops properly to prevent mold',
                                  'Store in clean, dry containers',
                                  'Use natural pest deterrents in storage',
                                  'Prepare soil for next planting season',
                                ],
                                tag: 'Harvest',
                                tagColor: AppColors.purple,
                                icon: Icons.grass_outlined,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
