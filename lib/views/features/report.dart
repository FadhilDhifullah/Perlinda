import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_perlinda/services/report_service.dart';
import 'package:flutter_perlinda/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuatLaporan extends StatefulWidget {
  @override
  _BuatLaporanState createState() => _BuatLaporanState();
}

class _BuatLaporanState extends State<BuatLaporan> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();
  DateTime? _selectedDate;
  bool _isChecked = false;
  File? _selectedFile;
  String? _fileUrl;
  LatLng? _selectedLocation;

  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();
  final ImagePicker _picker = ImagePicker();

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

  void _pickFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitReport() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (_judulController.text.isEmpty ||
        _isiController.text.isEmpty ||
        _selectedDate == null ||
        _selectedLocation == null ||
        user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (_selectedFile != null) {
      _fileUrl = await _storageService.uploadFile(_selectedFile!,
          'reports/${DateTime.now().millisecondsSinceEpoch}.jpg');
    }

    await _firestoreService.addReport(
      userId: user.uid,
      title: _judulController.text,
      content: _isiController.text,
      date: _selectedDate!,
      location:
          'Lat: ${_selectedLocation!.latitude}, Lng: ${_selectedLocation!.longitude}',
      isAnonymous: _isChecked,
      attachmentUrl: _fileUrl,
    );

    _judulController.clear();
    _isiController.clear();
    setState(() {
      _selectedDate = null;
      _isChecked = false;
      _selectedFile = null;
      _fileUrl = null;
      _selectedLocation = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Report submitted successfully')),
    );
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
            SizedBox(width: 48),
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
                  onTap: (tapPosition, point) {
                    setState(() {
                      _selectedLocation = point;
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  if (_selectedLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: _selectedLocation!,
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
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF00355C)),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                width: width - 32,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Color(0xFFC1D9F1),
                ),
                child: _selectedFile != null
                    ? Image.file(
                        _selectedFile!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Text(
                          'Pilih File',
                          style: TextStyle(
                            color: Color(0xFF00355C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Laporan Anonim",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00355C),
                  ),
                ),
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: _submitReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4682A9),
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 32.0,
                  ),
                ),
                child: Text(
                  "Kirim Laporan",
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
