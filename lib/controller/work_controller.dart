import 'package:flutter/material.dart';
import '../service/firestore_service.dart';
import '../model/work_model.dart';

class WorkController extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  
  Future<void> addWork(WorkModel work) async {
    await _firestoreService.addWork(work);
    notifyListeners();
  }

  Stream<List<WorkModel>> get allWorks => _firestoreService.getWorks();
}
