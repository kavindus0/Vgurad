import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vguard/models/disease.dart';

class DiseaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to get all diseases
  Future<List<Disease>> getAllDiseases() async {
    try {
      final querySnapshot = await _firestore.collection('diseases').get();
      return querySnapshot.docs
          .map((doc) => Disease.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error fetching diseases: $e');
      return [];
    }
  }

  // Method to add a new disease
  Future<void> addDisease(Disease disease) async {
    try {
      await _firestore.collection('diseases').add(disease.toFirestore());
      print('Disease added successfully: ${disease.name}');
    } catch (e) {
      print('Error adding disease: $e');
    }
  }

  Future<List<Disease>> getDiseasesByCategory(String category) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore
              .collection('diseases')
              .where('category', isEqualTo: category)
              .get();
      return querySnapshot.docs
          .map(
            (doc) => Disease.fromFirestore(
              doc.data() as Map<String, dynamic>,
              doc.id,
            ),
          )
          .toList();
    } catch (e) {
      print('Error fetching diseases by category: $e');
      return [];
    }
  }

  Future<List<Disease>> searchDiseases(String query) async {
    try {
      final allDiseases =
          await getAllDiseases(); // Fetch all and filter client-side
      final lowerCaseQuery = query.toLowerCase();
      return allDiseases.where((disease) {
        return disease.name.toLowerCase().contains(lowerCaseQuery) ||
            disease.category.toLowerCase().contains(lowerCaseQuery) ||
            disease.symptoms.toLowerCase().contains(lowerCaseQuery);
      }).toList();
    } catch (e) {
      print('Error searching diseases: $e');
      return [];
    }
  }
}
