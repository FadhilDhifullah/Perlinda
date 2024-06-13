import 'package:flutter/material.dart';
import 'package:flutter_perlinda/views/features/kpppa_detail_laporan.dart';

class KPPPAReportHistories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        title: Center(
          child: Text(
            "Daftar Laporan Diterima",
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
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 400,
            height: 190,
            child: Card(
              color: Color(0xFFC1D9F1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID Laporan 44621',
                      style: TextStyle(
                        color: Color(0xFF00355C),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Judul: Kekerasan dalam rumah tangga',
                      style: TextStyle(color: Color(0xFF00355C)),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Status: Sedang diverifikasi',
                      style: TextStyle(color: Color(0xFF00355C)),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Pelapor: Linda Permatasari',
                      style: TextStyle(color: Color(0xFF00355C)),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KPPPADetailLaporan(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color(0xFF00355C), // Warna latar belakang tombol
                          foregroundColor: Colors.white, // Warna teks tombol
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ), // Menambah tinggi tombol
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                4.0), // Mengurangi rounded pada tombol
                          ),
                        ),
                        child: Text('Lihat Detail'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: KPPPAReportHistories(),
    ));
