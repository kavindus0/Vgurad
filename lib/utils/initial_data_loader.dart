import 'package:vguard/models/disease.dart';
import 'package:vguard/models/expert.dart';
import 'package:vguard/models/farmer_tip.dart';
import 'package:vguard/services/disease_service.dart';
import 'package:vguard/services/expert_service.dart';
import 'package:vguard/services/farmer_tip_service.dart';

class InitialDataLoader {
  final ExpertService _expertService = ExpertService();
  final DiseaseService _diseaseService = DiseaseService();
  final FarmerTipService _farmerTipService = FarmerTipService();

  Future<void> loadAllInitialData() async {
    print('Starting to load initial data...');
    await _loadExperts();
    await _loadDiseases();
    await _loadFarmerTips();
    print('Finished loading initial data.');
  }

  Future<void> _loadExperts() async {
    print('Loading experts...');
    final experts = [
      Expert(
        name: 'Dr. Priya Kumari',
        specialty: 'Plant Pathology',
        experience: '15 years experience',
        languages: ['English', 'Sinhala', 'Tamil'],
        rating: 4.8,
      ),
      Expert(
        name: 'Mr. Rajan Silva',
        specialty: 'Pest Management',
        experience: '12 years experience',
        languages: ['Sinhala', 'English'],
        rating: 4.6,
      ),
      Expert(
        name: 'Ms. Ayisha Fernando',
        specialty: 'Soil Science',
        experience: '8 years experience',
        languages: ['English', 'Sinhala'],
        rating: 4.7,
      ),
      Expert(
        name: 'Dr. Kumar Perera',
        specialty: 'Crop Nutrition',
        experience: '20 years experience',
        languages: ['Tamil', 'English'],
        rating: 4.9,
      ),
    ];
    for (var expert in experts) {
      await _expertService.addExpert(expert);
    }
    print('Experts loaded.');
  }

  Future<void> _loadDiseases() async {
    print('Loading diseases...');
    final diseases = [
      Disease(
        name: 'Leaf Blight (Tomato)',
        symptoms: 'Yellow spots, brown lesions, leaf curl.',
        treatment:
            'Apply fungicides, remove infected leaves, improve air circulation.',
        prevention: 'Use resistant varieties, proper spacing, clean tools.',
        category: 'Fungal',
        imageUrl:
            'https://placehold.co/300x200/FF0000/FFFFFF?text=Tomato+Blight',
      ),
      Disease(
        name: 'Powdery Mildew (Cucumber)',
        symptoms: 'White powdery patches on leaves and stems.',
        treatment:
            'Spray with neem oil or sulfur-based fungicides, remove affected parts.',
        prevention:
            'Good air circulation, avoid overhead watering, use resistant varieties.',
        category: 'Fungal',
        imageUrl:
            'https://placehold.co/300x200/00FF00/000000?text=Powdery+Mildew',
      ),
      Disease(
        name: 'Bacterial Wilt (Eggplant)',
        symptoms:
            'Sudden wilting of entire plant, discoloration of vascular tissue.',
        treatment:
            'No chemical cure. Remove and destroy infected plants. Crop rotation.',
        prevention:
            'Use resistant varieties, improve soil drainage, avoid injury to roots.',
        category: 'Bacterial',
        imageUrl: null,
      ),
      Disease(
        name: 'Aphid Infestation (General)',
        symptoms:
            'Curled, yellowing leaves, sticky honeydew, presence of small insects.',
        treatment:
            'Spray with insecticidal soap, introduce natural predators (ladybugs).',
        prevention: 'Monitor regularly, plant trap crops, ensure plant health.',
        category: 'Pest',
        imageUrl: 'https://placehold.co/300x200/0000FF/FFFFFF?text=Aphids',
      ),
    ];
    for (var disease in diseases) {
      await _diseaseService.addDisease(disease);
    }
    print('Diseases loaded.');
  }

  Future<void> _loadFarmerTips() async {
    print('Loading farmer tips...');
    final tips = [
      FarmerTip(
        title: 'Pre-Monsoon Preparation',
        content:
            'Clean and prepare drainage channels. Check irrigation systems for proper functioning. Apply organic matter to improve soil structure. Plant cover crops to prevent soil erosion.',
        category: 'Seasonal',
        dateAdded: DateTime(2023, 4, 15),
      ),
      FarmerTip(
        title: 'Hot Weather Crop Care',
        content:
            'Water crops early morning or late evening. Use mulching to retain soil moisture. Provide shade nets for sensitive crops. Monitor plants for heat stress symptoms.',
        category: 'Weather',
        dateAdded: DateTime(2023, 6, 1),
      ),
      FarmerTip(
        title: 'Pest Control During Monsoon',
        content:
            'Increase fungicide applications. Remove standing water to prevent breeding. Implement integrated pest management. Use organic pesticides where possible.',
        category: 'Pest Management',
        dateAdded: DateTime(2023, 7, 10),
      ),
      FarmerTip(
        title: 'Post-Harvest Care',
        content:
            'Dry crops properly to prevent mold. Store in clean, dry containers. Use natural pest deterrents in storage. Prepare soil for next planting season.',
        category: 'Harvest',
        dateAdded: DateTime(2023, 10, 5),
      ),
      FarmerTip(
        title: 'Soil Health for Next Season',
        content:
            'Conduct soil tests. Replenish nutrients with compost. Consider cover cropping for winter months.',
        category: 'Soil Care',
        dateAdded: DateTime(2023, 11, 20),
      ),
      FarmerTip(
        title: 'Early Spring Planting Tips',
        content:
            'Prepare beds early. Choose cold-tolerant varieties. Protect young seedlings from frost.',
        category: 'Seasonal',
        dateAdded: DateTime(2024, 3, 1),
      ),
      FarmerTip(
        title: 'Drought Management Strategies',
        content:
            'Utilize drip irrigation. Select drought-resistant crops. Practice water-wise gardening.',
        category: 'Weather',
        dateAdded: DateTime(2024, 5, 10),
      ),
    ];
    for (var tip in tips) {
      await _farmerTipService.addFarmerTip(tip);
    }
    print('Farmer tips loaded.');
  }
}
