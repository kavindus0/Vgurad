import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color? backgroundColor;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSizes.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
        side: BorderSide(
          color:
              backgroundColor == null ? AppColors.grey200 : AppColors.amber200,
        ),
      ),
      color: backgroundColor ?? AppColors.lightGreenBackground,
      child: Padding(
        // Reduced padding slightly to give more room for content
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.paddingMedium,
          horizontal: AppSizes.paddingLarge,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color:
                    backgroundColor == null
                        ? AppColors.primaryGreen
                        : AppColors.black87,
                fontSize: AppSizes.iconSizeLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.paddingSmall),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    backgroundColor == null
                        ? AppColors.grey700
                        : AppColors.grey700,
                fontSize: AppSizes.paddingMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
