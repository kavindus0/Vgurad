import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';

class AnalysisData {
  final String diseaseName;
  final String confidence;
  final List<String> symptoms;
  final List<Treatment> treatments;
  final List<String> preventionTips;

  AnalysisData({
    required this.diseaseName,
    required this.confidence,
    required this.symptoms,
    required this.treatments,
    required this.preventionTips,
  });
}

class Treatment {
  final String name;
  final String dosage;
  final String application;

  Treatment({
    required this.name,
    required this.dosage,
    required this.application,
  });
}

class CropDiseaseScannerPage extends StatefulWidget {
  const CropDiseaseScannerPage({super.key});

  @override
  State<CropDiseaseScannerPage> createState() => _CropDiseaseScannerPageState();
}

class _CropDiseaseScannerPageState extends State<CropDiseaseScannerPage> {
  String? _selectedImagePath;
  AnalysisData? _analysisResult;
  bool _showResults = false;

  // Data for the demo image analysis
  final AnalysisData _demoAnalysisData = AnalysisData(
    diseaseName: 'Leaf Blight',
    confidence: '85%',
    symptoms: ['Yellow spots on leaves', 'Brown edges', 'Wilting'],
    treatments: [
      Treatment(
        name: 'Copper Fungicide',
        dosage: '2ml per liter of water',
        application: 'Spray on affected areas twice weekly',
      ),
      Treatment(
        name: 'Neem Oil',
        dosage: '5ml per liter of water',
        application: 'Apply during evening hours',
      ),
    ],
    preventionTips: [
      'Ensure proper drainage',
      'Maintain adequate spacing between plants',
      'Use disease-resistant varieties',
      'Monitor regularly for early signs',
    ],
  );

  void _useDemoPhoto() {
    setState(() {
      _selectedImagePath = 'assets/images/crop.jpg';
      _showResults = false;
      _analysisResult = null;
    });
  }

  void _analyzeCrop() {
    if (_selectedImagePath != null) {
      setState(() {
        _analysisResult = _demoAnalysisData;
        _showResults = true;
      });
    }
  }

  void _clearSelection() {
    setState(() {
      _selectedImagePath = null;
      _analysisResult = null;
      _showResults = false;
    });
  }

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
                  'Crop Disease Scanner',
                  style: AppTextStyles.pageHeaderTitle,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                padding: const EdgeInsets.all(AppSizes.paddingLarge),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildCaptureUploadCard()),
                        const SizedBox(width: AppSizes.horizontalSpacing),
                        Expanded(child: _buildAnalysisResultsCard()),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaptureUploadCard() {
    return Card(
      elevation: AppSizes.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
        side: BorderSide(color: AppColors.grey300, style: BorderStyle.solid),
      ),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingXLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.black87,
                  size: AppSizes.iconSizeLarge,
                ),
                const SizedBox(width: AppSizes.paddingSmall),
                const Text(
                  'Capture or Upload Image',
                  style: AppTextStyles.featureCardTitle,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.paddingXLarge),
            // Image Preview Area
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(
                  AppSizes.borderRadiusMedium,
                ),
                border: Border.all(
                  color: AppColors.grey200,
                  style: BorderStyle.solid,
                ),
              ),
              child:
                  _selectedImagePath != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadiusMedium,
                        ),
                        child: Image.asset(
                          _selectedImagePath!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.grey400,
                            size: AppSizes.iconSizeHero,
                          ),
                          const SizedBox(height: AppSizes.paddingSmall),
                          Text(
                            'Take a photo or upload an image of your\ncrop',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.grey600),
                          ),
                        ],
                      ),
            ),
            const SizedBox(height: AppSizes.paddingXLarge),
            // Dynamic Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed:
                    _selectedImagePath == null ? _useDemoPhoto : _analyzeCrop,
                icon:
                    _selectedImagePath == null
                        ? const Icon(Icons.photo_library_outlined)
                        : const Icon(Icons.analytics_outlined),
                label: Text(
                  _selectedImagePath == null
                      ? 'Use Demo Photo'
                      : 'Analyze Crop',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.paddingMedium,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadiusMedium,
                    ),
                  ),
                  elevation: AppSizes.cardElevation,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.paddingSmall + 4),
            // Upload Image Button or Clear Button
            SizedBox(
              width: double.infinity,
              child:
                  _selectedImagePath == null
                      ? ElevatedButton.icon(
                        onPressed: () {
                          print('Upload Image tapped!');
                        },
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Upload Image'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.black87,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.paddingMedium,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadiusMedium,
                            ),
                            side: BorderSide(color: AppColors.grey300),
                          ),
                          elevation: AppSizes.cardElevation,
                        ),
                      )
                      : OutlinedButton.icon(
                        onPressed: _clearSelection,
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              AppColors.red, // Red color for clear button
                          side: const BorderSide(color: AppColors.red),
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.paddingMedium,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadiusMedium,
                            ),
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisResultsCard() {
    return Card(
      elevation: AppSizes.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
        side: BorderSide(color: AppColors.grey300),
      ),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingXLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
          children: [
            const Text(
              'Analysis Results',
              style: AppTextStyles.featureCardTitle,
            ),
            const SizedBox(height: AppSizes.paddingXLarge),
            _showResults && _analysisResult != null
                ? Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _analysisResult!.diseaseName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black87,
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingSmall),
                        Text(
                          'Confidence: ${_analysisResult!.confidence}',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.grey700,
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingMedium),
                        const Text(
                          'Symptoms Detected:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black87,
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingSmall),
                        ..._analysisResult!.symptoms.map(
                          (symptom) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSizes.paddingSmall / 2,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: AppColors.primaryGreen,
                                ),
                                const SizedBox(width: AppSizes.paddingSmall),
                                Expanded(
                                  child: Text(
                                    symptom,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.grey700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingMedium),
                        const Text(
                          'Recommended Treatments:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black87,
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingSmall),
                        ..._analysisResult!.treatments.map(
                          (treatment) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSizes.paddingMedium,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(
                                    AppSizes.paddingSmall,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGreenBackground,
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.borderRadiusSmall,
                                    ),
                                  ),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        treatment.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryGreen,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: AppSizes.borderRadiusSmall,
                                      ),
                                      Text(
                                        'Dosage: ${treatment.dosage}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.grey700,
                                        ),
                                      ),
                                      Text(
                                        'Application: ${treatment.application}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.grey700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingMedium),
                        const Text(
                          'Prevention Tips:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black87,
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingSmall),
                        ..._analysisResult!.preventionTips.map(
                          (tip) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSizes.paddingSmall / 2,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: AppColors.primaryGreen,
                                ),
                                const SizedBox(width: AppSizes.paddingSmall),
                                Expanded(
                                  child: Text(
                                    tip,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.grey700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                : Expanded(
                  child: Center(
                    child: Text(
                      'Upload an image to see analysis results',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.grey600,
                        fontSize: AppSizes.paddingMedium,
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
