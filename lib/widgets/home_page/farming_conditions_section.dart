import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';

class FarmingConditionsSection extends StatelessWidget {
  const FarmingConditionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge),
        padding: const EdgeInsets.all(AppSizes.paddingXLarge),
        decoration: BoxDecoration(
          color: AppColors.lightGreenBackground,
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingSmall + 4,
                    vertical: AppSizes.paddingSmall - 2,
                  ),
                  decoration: BoxDecoration(
                    color:
                        Colors
                            .lightGreen, // Using direct color here as it's specific
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadiusLarge,
                    ),
                  ),
                  child: const Text(
                    'Optimal',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.paddingXLarge),
            LayoutBuilder(
              builder: (context, constraints) {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ConditionItem(
                        icon: Icons.wb_sunny_outlined,
                        value: '28°C',
                        label: 'Temperature',
                        iconColor: AppColors.amber,
                      ),
                    ),
                    Expanded(
                      child: ConditionItem(
                        icon: Icons.cloud_outlined,
                        value: '65%',
                        label: 'Humidity',
                        iconColor: AppColors.blueGrey,
                      ),
                    ),
                    Expanded(
                      child: ConditionItem(
                        icon: Icons.trending_up,
                        value: 'Good',
                        label: 'Growth',
                        iconColor: AppColors.green,
                      ),
                    ),
                    Expanded(
                      child: ConditionItem(
                        icon: Icons.shield_outlined,
                        value: 'Low',
                        label: 'Disease Risk',
                        iconColor: AppColors.deepOrange,
                      ),
                    ),
                  ],
                );
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
