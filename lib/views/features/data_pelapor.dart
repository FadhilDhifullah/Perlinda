import 'package:flutter/material.dart';

class DataPelapor extends StatelessWidget {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            buildTextFormField('NIK', '3574082208943210'),
            buildTextFormField('Jenis Kelamin', 'Perempuan'),
            buildTextFormField('Tempat Lahir', 'Jakarta'),
            buildTextFormField('Tanggal Lahir', '13 Februari 1996'),
            buildTextFormField(
                'Alamat Lengkap (Sesuai KTP)', 
                'Jalan Megah Indah Raya No. 10\nKelurahan Setia Budi, Kecamatan Kuningan\nJakarta Selatan 12950'
            ),
            buildTextFormField(
                'Alamat Domisili', 
                'Jalan Megah Indah Raya No. 10\nKelurahan Setia Budi, Kecamatan Kuningan\nJakarta Selatan 12950'
            ),
            buildTextFormField('Status Pernikahan', 'Kawin Tercatat'),
          ],
        ),
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
