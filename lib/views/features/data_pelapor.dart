import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataPelapor extends StatelessWidget {
  final String userId;

  DataPelapor({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        title: Center(
          child: Text(
            "Data Pelapor",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('dataDiri').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Data not found'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                buildTextFormField('NIK', userData['nik'] ?? ''),
                buildTextFormField(
                    'Jenis Kelamin', userData['jenis_kelamin'] ?? ''),
                buildTextFormField(
                    'Tempat Lahir', userData['tempat_lahir'] ?? ''),
                buildTextFormField(
                    'Tanggal Lahir', userData['tanggal_lahir'] ?? ''),
                buildTextFormField('Alamat Lengkap (Sesuai KTP)',
                    userData['alamat_lengkap'] ?? ''),
                buildTextFormField(
                    'Status Pernikahan', userData['status_pernikahan'] ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTextFormField(String labelText, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00355C),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFC1D9F1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xFF00355C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
