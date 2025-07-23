import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';
import 'package:vguard/pages/ask_advisor_page.dart';
import 'package:vguard/widgets/expert_help_page/expert_card.dart';
import 'package:vguard/widgets/expert_help_page/expert_tab_button.dart';

class ExpertHelpPage extends StatelessWidget {
  const ExpertHelpPage({super.key});

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
                const Text('Expert Help', style: AppTextStyles.pageHeaderTitle),
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
                      Row(
                        children: [
                          Expanded(
                            child: ExpertTabButton(
                              label: 'Experts',
                              icon: Icons.person_outline,
                              isSelected: true,
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: ExpertTabButton(
                              label: 'Ask Question',
                              icon: Icons.question_answer_outlined,
                              isSelected: false,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AskAdvisorPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: ExpertTabButton(
                              label: 'My Questions',
                              icon: Icons.history,
                              isSelected: false,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.paddingXXLarge),

                      const Text(
                        'Available Agricultural Experts',
                        style: AppTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: AppSizes.paddingMedium),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount =
                              (constraints.maxWidth > 700) ? 2 : 1;
                          double childAspectRatio =
                              (constraints.maxWidth > 700) ? 1.5 : 1.2;

                          return GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: childAspectRatio,
                            mainAxisSpacing: AppSizes.verticalSpacing,
                            crossAxisSpacing: AppSizes.horizontalSpacing,
                            children: const [
                              ExpertCard(
                                name: 'Dr. Priya Kumari',
                                specialty: 'Plant Pathology',
                                experience: '15 years experience',
                                languages: ['English', 'Sinhala', 'Tamil'],
                                rating: 4.8,
                              ),
                              ExpertCard(
                                name: 'Mr. Rajan Silva',
                                specialty: 'Pest Management',
                                experience: '12 years experience',
                                languages: ['Sinhala', 'English'],
                                rating: 4.6,
                              ),
                              ExpertCard(
                                name: 'Ms. Ayisha Fernando',
                                specialty: 'Soil Science',
                                experience: '8 years experience',
                                languages: ['English', 'Sinhala'],
                                rating: 4.7,
                              ),
                              ExpertCard(
                                name: 'Dr. Kumar Perera',
                                specialty: 'Crop Nutrition',
                                experience: '20 years experience',
                                languages: ['Tamil', 'English'],
                                rating: 4.9,
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
