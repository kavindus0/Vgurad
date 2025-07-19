import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';
import 'package:vguard/widgets/common/pill_button.dart';
import 'package:vguard/widgets/common/stat_card.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(height: 15),
        Container(
          width: screenWidth * 0.98,
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.paddingHeroVertical,
            horizontal: screenWidth * 0.05,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryGreen, // Start color
                AppColors.darkGreen, // End color
              ],
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Protect Your Crops with AI',
                      style: AppTextStyles.heroTitle,
                    ),
                    const SizedBox(height: AppSizes.paddingMedium),
                    const Text(
                      'Detect diseases early, get expert treatment advice, and keep your farm healthy with Vguard\'s intelligent crop protection system.',
                      style: AppTextStyles.heroDescription,
                    ),
                    const SizedBox(height: AppSizes.paddingXXLarge),
                    Wrap(
                      spacing: AppSizes.paddingSmall + 4,
                      runSpacing: AppSizes.paddingSmall + 4,
                      children: const [
                        PillButton(
                          text: 'AI Disease Detection',
                          icon: Icons.lightbulb_outline,
                        ),
                        PillButton(
                          text: 'Expert Advice',
                          icon: Icons.person_outline,
                        ),
                        PillButton(
                          text: 'Organic Solutions',
                          icon: Icons.eco_outlined,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: (AppSizes.paddingHeroVertical) * 0.5),
        SizedBox(
          width: screenWidth * 0.98,
          child: GridView.count(
            crossAxisCount: screenWidth < 600 ? 2 : 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // Adjusted childAspectRatio to make cards taller and prevent overflow
            childAspectRatio:
                screenWidth < 600 ? 1.8 : 2.2, // Made taller for small screens
            crossAxisSpacing: AppSizes.horizontalSpacing,
            mainAxisSpacing: AppSizes.horizontalSpacing,
            children: const [
              StatCard(value: '50+', label: 'Diseases Detected'),
              StatCard(value: '1000+', label: 'Farmers Helped'),
              StatCard(
                value: '24/7',
                label: 'Expert Support',
                backgroundColor: AppColors.yellowBackground,
              ),
              StatCard(value: '95%', label: 'Accuracy Rate'),
            ],
          ),
        ),
      ],
    );
  }
}
