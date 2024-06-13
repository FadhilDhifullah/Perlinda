import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReportHistoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getReportsByUser() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    return _db
        .collection('reports')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id; // Add document ID to the data
        return data;
      }).toList();
    });
  }

  Future<Map<String, dynamic>> getReportById(String reportId) async {
    DocumentSnapshot doc = await _db.collection('reports').doc(reportId).get();
    return doc.data() as Map<String, dynamic>;
  }
}
