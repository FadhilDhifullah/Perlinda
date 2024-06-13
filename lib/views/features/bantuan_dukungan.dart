import 'package:flutter/material.dart';

class BantuanDukungan extends StatefulWidget {
  const BantuanDukungan({Key? key}) : super(key: key);

  @override
  State<BantuanDukungan> createState() => _DukunganBantuanState();
}

class _DukunganBantuanState extends State<BantuanDukungan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Bantuan & Dukungan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Warna teks putih
        ),
        backgroundColor: Color(0xFF4682A9), // Background color
        iconTheme: IconThemeData(color: Colors.white), // Mengatur warna ikon kembali menjadi putih
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hubungi Kami',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Container(
              color: Color(0xFFC1D9F1), // Warna background
              child: TextFormField(
                initialValue: 'teamglorious@gmail.com',
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFC1D9F1), // Warna background
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


