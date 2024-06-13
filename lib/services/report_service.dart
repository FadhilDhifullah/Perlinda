import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addReport({
    required String title,
    required String content,
    required DateTime date,
    required String location,
    required bool isAnonymous,
  }) async {
    try {
      await _db.collection('reports').add({
        'title': title,
        'content': content,
        'date': date.toIso8601String(),
        'location': location,
        'isAnonymous': isAnonymous,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding report: $e');
    }
  }
}
