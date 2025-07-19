import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryChip({super.key, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        print('Category chip "$label" ${selected ? "selected" : "unselected"}');
      },
      selectedColor: AppColors.primaryGreen,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.white : AppColors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: AppColors.grey200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
        side:
            isSelected ? BorderSide.none : BorderSide(color: AppColors.grey300),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingSmall + 2,
      ),
    );
  }
}
