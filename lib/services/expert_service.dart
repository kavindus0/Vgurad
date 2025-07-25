import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vguard/models/expert.dart';

class ExpertService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to get all experts
  Future<List<Expert>> getExperts() async {
    try {
      final querySnapshot = await _firestore.collection('experts').get();
      return querySnapshot.docs
          .map((doc) => Expert.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error fetching experts: $e');
      return [];
    }
  }

  // Add a new expert
  Future<void> addExpert(Expert expert) async {
    try {
      await _firestore.collection('experts').add(expert.toFirestore());
      print('Expert added successfully: ${expert.name}');
    } catch (e) {
      print('Error adding expert: $e');
    }
  }
}
