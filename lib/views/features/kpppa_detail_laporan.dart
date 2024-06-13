import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import

class KPPPADetailLaporan extends StatefulWidget {
  final Map<String, dynamic> report;

  KPPPADetailLaporan({required this.report});

  @override
  _KPPPADetailLaporanState createState() => _KPPPADetailLaporanState();
}

class _KPPPADetailLaporanState extends State<KPPPADetailLaporan> {
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.report['status'] ?? 'Sedang diverifikasi';

    // Pastikan _selectedStatus adalah salah satu dari nilai yang tersedia
    final validStatuses = [
      'Laporan diterima',
      'Sedang diverifikasi',
      'Bantuan awal',
      'Proses hukum',
      'Kasus selesai'
    ];
    if (!validStatuses.contains(_selectedStatus)) {
      _selectedStatus = 'Sedang diverifikasi';
    }
  }

  @override
  Widget build(BuildContext context) {
    final report = widget.report;
    final Timestamp timestamp = report['date'];
    final date = timestamp.toDate();
    final formattedDate = DateFormat('dd-MM-yyyy').format(date);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        title: Center(
          child: Text(
            "Detail Laporan",
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
          children: [
            buildDetailItem(context, 'Nama Pelapor', report['reporterName']),
            buildDetailItem(context, 'Judul Laporan', report['title']),
            buildDetailItem(context, 'Isi Laporan', report['content']),
            buildDetailItem(context, 'Tanggal Kejadian', formattedDate),
            buildLocationDetailItem('Lokasi Kejadian'),
            buildDetailItem(context, 'Lampiran',
                report['attachmentUrl'] ?? 'No attachment available',
                isFile: true),
            buildStatusDropdown(),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add save functionality here
                  // You can add code to save the status to Firestore or any other database
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color(0xFF4682A9), // Warna latar belakang tombol
                  foregroundColor: Colors.white, // Warna teks tombol
                  padding: EdgeInsets.symmetric(
                      vertical: 18.0,
                      horizontal: 80.0), // Menambah tinggi tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        4.0), // Mengurangi rounded pada tombol
                  ),
                ),
                child: Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailItem(BuildContext context, String title, String value,
      {bool isLink = false, bool isDate = false, bool isFile = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF00355C),
              fontWeight: FontWeight.bold,
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
            child: isLink
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataPelapor(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value,
                          style: TextStyle(color: Color(0xFF00355C)),
                        ),
                        Text(
                          'Lihat data pelapor',
                          style: TextStyle(
                            color: Color(0xFF4682A9),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  )
                : isDate
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value,
                            style: TextStyle(color: Color(0xFF00355C)),
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: Color(0xFF00355C),
                          ),
                        ],
                      )
                    : isFile
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                value,
                                style: TextStyle(color: Color(0xFF00355C)),
                              ),
                              Icon(Icons.file_present,
                                  color: Color(0xFF00355C)),
                            ],
                          )
                        : Text(
                            value,
                            style: TextStyle(color: Color(0xFF00355C)),
                          ),
          ),
        ],
      ),
    );
  }

  Widget buildLocationDetailItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF00355C),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Color(0xFFC1D9F1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.asset(
              'images/map_sample.png', // ganti dengan gambar peta yang sesuai
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStatusDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status Laporan',
            style: TextStyle(
              color: Color(0xFF00355C),
              fontWeight: FontWeight.bold,
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
            child: DropdownButton<String>(
              value: _selectedStatus,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Color(0xFF00355C)),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Color(0xFF00355C)),
              underline: Container(
                height: 2,
                color: Color(0xFF00355C),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue;
                });
              },
              items: <String>[
                'Laporan diterima',
                'Sedang diverifikasi',
                'Bantuan awal',
                'Proses hukum',
                'Kasus selesai'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

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
            buildTextFormField('Alamat Lengkap (Sesuai KTP)',
                'Jalan Megah Indah Raya No. 10\nKelurahan Setia Budi, Kecamatan Kuningan\nJakarta Selatan 12950'),
            buildTextFormField('Alamat Domisili',
                'Jalan Megah Indah Raya No. 10\nKelurahan Setia Budi, Kecamatan Kuningan\nJakarta Selatan 12950'),
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

void main() => runApp(MaterialApp(
      home: KPPPADetailLaporan(report: {
        'reporterName': 'Linda Permatasari',
        'title': 'Kekerasan dalam rumah tangga',
        'content':
            'Saya mengalami kekerasan dalam rumah tangga yang dilakukan oleh suami saya. Kejadian ini terjadi di rumah kami. Saya dipukul dan ditendang hingga mengalami luka-luka di beberapa bagian tubuh.',
        'date': Timestamp.fromDate(DateTime(2024, 4, 23)), // Use Timestamp here
        'attachmentUrl': 'buktivisum.jpg',
        'status': 'Sedang diverifikasi',
      }),
    ));
