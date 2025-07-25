import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vguard/models/disease.dart';
import 'package:vguard/models/expert.dart';
import 'package:vguard/models/farmer_tip.dart';

class AdminDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- Disease Database Operations ---

  Future<void> addDisease(Disease disease) async {
    await _firestore.collection('diseases').add(disease.toFirestore());
  }

  Stream<List<Disease>> getDiseases() {
    return _firestore
        .collection('diseases')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Disease.fromFirestore(doc.data(), doc.id))
              .toList();
        });
  }

  Future<void> deleteDisease(String id) async {
    await _firestore.collection('diseases').doc(id).delete();
  }

  // --- Farmer Tips Operations ---

  Future<void> addFarmerTip(FarmerTip tip) async {
    await _firestore.collection('farmerTips').add(tip.toFirestore());
  }

  Stream<List<FarmerTip>> getFarmerTips() {
    return _firestore
        .collection('farmerTips')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => FarmerTip.fromFirestore(doc.data(), doc.id))
              .toList();
        });
  }

  Future<void> deleteFarmerTip(String id) async {
    await _firestore.collection('farmerTips').doc(id).delete();
  }

  // --- Expert Help Operations ---

  Future<void> addExpert(Expert expert) async {
    await _firestore.collection('experts').add(expert.toFirestore());
  }

  Stream<List<Expert>> getExperts() {
    return _firestore
        .collection('experts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Expert.fromFirestore(doc.data(), doc.id))
              .toList();
        });
  }

  Future<void> deleteExpert(String id) async {
    await _firestore.collection('experts').doc(id).delete();
  }
}
