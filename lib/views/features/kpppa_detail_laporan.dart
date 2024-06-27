import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'data_pelapor.dart'; // Import file data_pelapor.dart

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

    LatLng? location = _parseLocation(report['location']);

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
            buildDetailItem(context, 'Nama Pelapor', report['reporterName'],
                isLink: true, userId: report['userId']),
            buildDetailItem(context, 'Judul Laporan', report['title']),
            buildDetailItem(context, 'Isi Laporan', report['content']),
            buildDetailItem(context, 'Tanggal Kejadian', formattedDate),
            if (location != null)
              buildLocationDetailItem('Lokasi Kejadian', location),
            buildAttachmentItem(report['attachmentUrl']),
            buildStatusDropdown(),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _saveStatus(report['id']);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4682A9),
                  foregroundColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(vertical: 18.0, horizontal: 80.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
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

  void _saveStatus(String reportId) async {
    if (_selectedStatus == null) return;

    // Save the status to Firestore
    await FirebaseFirestore.instance
        .collection('reports')
        .doc(reportId)
        .update({
      'status': _selectedStatus,
      'statusHistory': FieldValue.arrayUnion([
        {'date': DateTime.now().toIso8601String(), 'status': _selectedStatus}
      ])
    });

    // Optionally show a success message or navigate back
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status laporan berhasil disimpan')),
    );
  }

  Widget buildDetailItem(BuildContext context, String title, String value,
      {bool isLink = false,
      bool isDate = false,
      bool isFile = false,
      String? userId}) {
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
                          builder: (context) => DataPelapor(userId: userId!),
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

  LatLng? _parseLocation(String location) {
    try {
      final parts = location.split(',');
      final lat = double.parse(parts[0].split(':')[1].trim());
      final lng = double.parse(parts[1].split(':')[1].trim());
      return LatLng(lat, lng);
    } catch (e) {
      return null;
    }
  }

  Widget buildLocationDetailItem(String title, LatLng location) {
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
            child: FlutterMap(
              options: MapOptions(
                center: location,
                zoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: location,
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAttachmentItem(String? attachmentUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lampiran',
            style: TextStyle(
              color: Color(0xFF00355C),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          if (attachmentUrl != null && attachmentUrl.isNotEmpty)
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFFC1D9F1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.network(
                attachmentUrl,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFFC1D9F1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'No attachment available',
                style: TextStyle(color: Color(0xFF00355C)),
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
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              isExpanded: true,
              style: TextStyle(color: Color(0xFF00355C)),
              underline: Container(
                height: 2,
                color: Colors.transparent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue!;
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
