import 'package:flutter/material.dart';

class KPPPADetailRiwayatLaporan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        title: Center(
          child: Text(
            "Detail Riwayat Laporan",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Laporan',
              style: TextStyle(
                color: Color(0xFF00355C),
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Id Laporan',
                    style: TextStyle(color: Color(0xFF00355C)),
                  ),
                  Text(
                    '44620',
                    style: TextStyle(
                      color: Color(0xFF00355C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Kekerasan dalam rumah tangga',
                    style: TextStyle(color: Color(0xFF00355C)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Riwayat Status Laporan',
              style: TextStyle(
                color: Color(0xFF00355C),
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView(
                children: [
                  buildStatusItem('23-04-2024 20:23', 'Laporan diterima'),
                  buildStatusItem('23-04-2024 20:23', 'Sedang diverifikasi'),
                  buildStatusItem('24-04-2024 20:23', 'Bantuan awal'),
                  buildStatusItem('24-04-2024 20:23', 'Proses Hukum'),
                  buildStatusItem('25-04-2024 20:23', 'Kasus Selesai'),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: SizedBox(
                width: double.infinity, // Mengatur lebar tombol
                height: 55.0, // Mengatur tinggi tombol
                child: ElevatedButton(
                  onPressed: () {
                    // Add refresh functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF4682A9), // Warna latar belakang tombol
                    foregroundColor: Colors.white, // Warna teks tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          4.0), // Mengurangi rounded pada tombol
                    ),
                  ),
                  child: Text('Refresh'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatusItem(String date, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFFD3D3D3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: TextStyle(color: Color(0xFF00355C)),
            ),
            Text(
              status,
              style: TextStyle(color: Color(0xFF00355C)),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: KPPPADetailRiwayatLaporan(),
    ));
