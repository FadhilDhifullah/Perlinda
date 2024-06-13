import 'package:cloud_firestore/cloud_firestore.dart';

class KPPPAReportService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getReports() {
    return _db.collection('reports').snapshots().asyncMap((snapshot) async {
      final userDocs = await _db.collection('users').get();
      final users = {for (var doc in userDocs.docs) doc.id: doc.data()};

      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;

        if (data['isAnonymous'] == true) {
          data['reporterName'] = 'Anonymous';
        } else {
          final userId = data['userId'];
          if (users.containsKey(userId)) {
            final userData = users[userId];
            data['reporterName'] =
                userData != null && userData.containsKey('full_name')
                    ? userData['full_name'] ?? 'Unknown'
                    : 'Unknown';
          } else {
            data['reporterName'] = 'Unknown';
          }
        }
        return data;
      }).toList();
    });
  }
}
