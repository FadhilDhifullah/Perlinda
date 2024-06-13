import 'package:flutter/material.dart';
import 'package:flutter_perlinda/views/features/report_history_details.dart';

class ReportHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Riwayat Laporan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 48), // To balance the space taken by IconButton
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Color(0xFFC1D9F1),
          child: ListTile(
            contentPadding: EdgeInsets.all(16.0),
            title: Text(
              'ID Laporan 44621',
              style: TextStyle(
                color: Color(0xFF00355C),
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            subtitle: Text(
              'Kekerasan Dalam Rumah Tangga',
              style: TextStyle(color: Color(0xFF00355C)),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                // Navigasi ke DetailRiwayatLaporan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailRiwayatLaporan()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFF00355C), // Warna latar belakang tombol
                foregroundColor: Colors.white, // Warna teks tombol
                padding: EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 20.0), // Menambah tinggi tombol
              ),
              child: Text('Lihat Riwayat'),
            ),
          ),
        ),
      ),
    );
  }
}
