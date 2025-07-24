import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';
import 'package:vguard/core/app_routes.dart';
import 'package:vguard/widgets/home_page/farming_conditions_section.dart';
import 'package:vguard/widgets/home_page/feature_cards_section.dart';
import 'package:vguard/widgets/home_page/hero_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.askAdvisor);
        },
        backgroundColor: AppColors.darkGreen,
        child: const Icon(Icons.question_answer, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.darkGreen,
        elevation: AppSizes.cardElevation,
        title: Image.asset(
          'assets/images/logo.png',
          height: 150,
          width: 150,
          fit: BoxFit.contain,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroSection(),
            const SizedBox(height: AppSizes.paddingXXLarge),
            const FeatureCardsSection(),
            const SizedBox(height: AppSizes.paddingXXLarge),
            const FarmingConditionsSection(),
            const SizedBox(height: AppSizes.paddingXXLarge),
          ],
        ),
      ),
    );
  }
}
