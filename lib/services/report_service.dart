import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addReport({
    required String userId,
    required String title,
    required String content,
    required DateTime date,
    required String location,
    required bool isAnonymous,
    String? attachmentUrl,
  }) async {
    await _db.collection('reports').add({
      'userId': userId,
      'title': title,
      'content': content,
      'date': date,
      'location': location,
      'isAnonymous': isAnonymous,
      'attachmentUrl': attachmentUrl,
    });
  }

  // Methods for retrieving reports would go here
}
