import 'package:flutter/material.dart';

class DetailRiwayatLaporan extends StatelessWidget {
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
                  "Detail Riwayat Laporan",
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Laporan',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00355C)),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(70.0),
              decoration: BoxDecoration(
                color: Color(0xFFC1D9F1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Id Laporan',
                    style: TextStyle(fontSize: 18, color: Color(0xFF00355C)),
                  ),
                  Text(
                    '44621',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00355C)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Kekerasan dalam rumah tangga',
                    style: TextStyle(fontSize: 16, color: Color(0xFF00355C)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Riwayat Status Laporan',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00355C)),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildStatusTile('23-04-2024 20:23', 'Laporan terkirim'),
                  _buildStatusTile('23-04-2024 20:23', 'Sedang diverifikasi'),
                  _buildStatusTile('24-04-2024 20:23', 'Melakukan Pemeriksaan'),
                  _buildStatusTile('24-04-2024 20:23', 'Melakukan Penindakan'),
                  _buildStatusTile('25-04-2024 20:23', 'Pemulihan'),
                ],
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Refresh",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4682A9),
                  foregroundColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
                  textStyle: TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold), // Teks bold
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Border radius 8
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatusTile(String date, String status) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(12.0),
    color: Colors.grey[200],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00355C)),
        ),
        Text(
          status,
          style: TextStyle(fontSize: 16, color: Color(0xFF00355C)),
        ),
      ],
    ),
  );
}
