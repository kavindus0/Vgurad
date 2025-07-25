import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vguard/models/farmer_tip.dart';

class FarmerTipService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all tips
  Future<List<FarmerTip>> getAllFarmerTips() async {
    try {
      final querySnapshot =
          await _firestore
              .collection('farmerTips')
              .orderBy('dateAdded', descending: true)
              .get();
      return querySnapshot.docs
          .map((doc) => FarmerTip.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error fetching all farmer tips: $e');
      return [];
    }
  }

  // Get tips by category
  Future<List<FarmerTip>> getFarmerTipsByCategory(String category) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('farmerTips')
              .where('category', isEqualTo: category)
              .orderBy('dateAdded', descending: true)
              .get();
      return querySnapshot.docs
          .map((doc) => FarmerTip.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error fetching farmer tips by category ($category): $e');
      return [];
    }
  }

  // Add a new farmer tip
  Future<void> addFarmerTip(FarmerTip tip) async {
    try {
      await _firestore.collection('farmerTips').add(tip.toFirestore());
      print('Farmer tip added successfully: ${tip.title}');
    } catch (e) {
      print('Error adding farmer tip: $e');
    }
  }
}
