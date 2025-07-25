import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';
import 'package:vguard/core/app_routes.dart';
import 'package:vguard/services/auth_service.dart';
import 'package:vguard/widgets/auth/login_popup.dart';
import 'package:vguard/widgets/home_page/farming_conditions_section.dart';
import 'package:vguard/widgets/home_page/feature_cards_section.dart';
import 'package:vguard/widgets/home_page/hero_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();

  void _showLoginPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LoginPopup();
      },
    );
  }

  // Function to handle sign out
  void _handleSignOut() async {
    await _authService.signOut();
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Logged out successfully!')));
    }
  }

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
        actions: [
          StreamBuilder<User?>(
            stream: _authService.authStateChanges,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(color: AppColors.white);
              } else if (snapshot.hasData && snapshot.data != null) {
                // User is logged in
                return Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingSmall),
                  child: Row(
                    children: [
                      Text(
                        snapshot.data!.displayName ??
                            snapshot.data!.email ??
                            'User',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: AppSizes.paddingSmall),
                      IconButton(
                        icon: const Icon(Icons.logout, color: AppColors.white),
                        onPressed: _handleSignOut,
                        tooltip: 'Logout',
                      ),
                    ],
                  ),
                );
              } else {
                // User is not logged in
                return Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingSmall),
                  child: TextButton(
                    onPressed: _showLoginPopup,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.darkGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadiusMedium,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingMedium,
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(width: AppSizes.paddingSmall),
        ],
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
