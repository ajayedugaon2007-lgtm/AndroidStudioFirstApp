import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/work_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add work
  Future<void> addWork(WorkModel work) async {
    await _firestore.collection('works').add(work.toMap());
  }

  // Get all works
  Stream<List<WorkModel>> getWorks() {
    return _firestore.collection('works').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return WorkModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Get works by category
  Stream<List<WorkModel>> getWorksByCategory(String category) {
    return _firestore.collection('works').where('category', isEqualTo: category).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return WorkModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
