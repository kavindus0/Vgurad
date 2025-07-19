import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';
import 'package:vguard/widgets/disease_database_page/disease_item_card.dart';

class DiseaseDatabasePage extends StatelessWidget {
  const DiseaseDatabasePage({super.key});

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
                  'Disease Database',
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
                    children: [
                      Card(
                        elevation: AppSizes.cardElevation,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadiusMedium,
                          ),
                          side: BorderSide(color: AppColors.grey300),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSizes.paddingMedium),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Search Diseases',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black87,
                                ),
                              ),
                              const SizedBox(height: AppSizes.paddingSmall + 4),
                              TextField(
                                decoration: InputDecoration(
                                  hintText:
                                      'Search by disease name or crop type...',
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: AppColors.grey600,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.borderRadiusMedium,
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.grey100,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: AppSizes.paddingMedium,
                                    horizontal: AppSizes.paddingSmall + 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.verticalSpacing),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount =
                              (constraints.maxWidth > 600) ? 2 : 1;
                          double childAspectRatio =
                              (constraints.maxWidth > 600) ? 2.0 : 1.5;

                          return GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: childAspectRatio,
                            mainAxisSpacing: AppSizes.verticalSpacing,
                            crossAxisSpacing: AppSizes.horizontalSpacing,
                            children: const [
                              DiseaseItemCard(
                                title: 'Leaf Blight',
                                crop: 'Rice',
                                description: 'Yellow spots, Brown edges...',
                                riskLevel: 'High',
                                riskColor: AppColors.red,
                              ),
                              DiseaseItemCard(
                                title: 'Powdery Mildew',
                                crop: 'Tomato',
                                description:
                                    'White powdery coating, Yellowing leaves...',
                                riskLevel: 'Medium',
                                riskColor: AppColors.orange,
                              ),
                              DiseaseItemCard(
                                title: 'Bacterial Wilt',
                                crop: 'Eggplant',
                                description: 'Sudden wilting, Yellow leaves...',
                                riskLevel: 'High',
                                riskColor: AppColors.red,
                              ),
                              DiseaseItemCard(
                                title: 'Aphid Infestation',
                                crop: 'Multiple crops',
                                description:
                                    'Curled leaves, Sticky honeydew...',
                                riskLevel: 'Low',
                                riskColor: AppColors.green,
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
