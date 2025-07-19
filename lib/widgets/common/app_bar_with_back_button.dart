import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';

class CustomAppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const CustomAppBarWithBackButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkGreen,
      elevation: AppSizes.cardElevation,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          const Icon(Icons.shield, color: AppColors.white),
          const SizedBox(width: AppSizes.paddingSmall),
          Text(title, style: AppTextStyles.appBarTitle),
        ],
      ),
      actions: [
        Container(
          width: AppSizes.iconSizeXXLarge,
          height: AppSizes.iconSizeXXLarge,
          margin: const EdgeInsets.only(right: AppSizes.paddingMedium),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
