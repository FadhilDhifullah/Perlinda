import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BuatLaporan extends StatefulWidget {
  @override
  _BuatLaporanState createState() => _BuatLaporanState();
}

class _BuatLaporanState extends State<BuatLaporan> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();
  DateTime? _selectedDate;
  bool _isChecked = false;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                  "Buat Laporan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
                width:
                    48), // Untuk menyeimbangkan ruang yang diambil oleh IconButton
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Judul Laporan",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00355C),
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _judulController,
              decoration: InputDecoration(
                hintText: "Ketik Judul Laporan",
                hintStyle: TextStyle(color: Color(0xFF00355C)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Color(0xFFC1D9F1),
              ),
              style: TextStyle(color: Color(0xFF00355C)),
            ),
            SizedBox(height: 16.0),
            Text(
              "Isi Laporan",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00355C),
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _isiController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Ketik isi laporan",
                hintStyle: TextStyle(color: Color(0xFF00355C)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Color(0xFFC1D9F1),
              ),
              style: TextStyle(color: Color(0xFF00355C)),
            ),
            SizedBox(height: 16.0),
            Text(
              "Tanggal Kejadian",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00355C),
              ),
            ),
            SizedBox(height: 8.0),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                width: width - 32,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Color(0xFFC1D9F1),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  _selectedDate == null
                      ? 'Pilih tanggal kejadian'
                      : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                  style: TextStyle(color: Color(0xFF00355C)),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Lokasi Kejadian",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00355C),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              height: 150.0,
              color: Colors.grey[300],
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(-6.200000, 106.816666),
                  zoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Upload Lampiran",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00355C),
                  ),
                ),
                Text(
                  "*Dapat berisi foto/bukti pendukung",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF00355C),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
                backgroundColor: Color(0xFFC1D9F1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.attach_file, color: Color(0xFF00355C)),
                  SizedBox(width: 8.0),
                  Text(
                    "Upload Lampiran",
                    style: TextStyle(color: Color(0xFF00355C)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _isChecked, // Gunakan variabel status
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ??
                          false; // Perbarui status saat checkbox diklik
                    });
                  },
                ),
                Text(
                  "Anonim",
                  style: TextStyle(color: Color(0xFF00355C)),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Buat Laporan",
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
