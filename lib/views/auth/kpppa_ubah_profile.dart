import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class KPPPAUbahProfile extends StatefulWidget {
  const KPPPAUbahProfile({Key? key}) : super(key: key);

  @override
  State<KPPPAUbahProfile> createState() => _KPPPAUbahProfileState();
}

class _KPPPAUbahProfileState extends State<KPPPAUbahProfile> {
  File? _image;
  TextEditingController _namaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _noHandphoneController = TextEditingController();

  @override 
  void initState() {
    _namaController.text = 'Meilin Ayu Sari';
    _emailController.text = 'meilinayusari48@gmail.com';
    _passwordController.text = '********';
    _alamatController.text = 'Jl. Brawijaya No. 3 Kaliwates, Jember';
    _noHandphoneController.text = '+6282142856282';
    super.initState();
  }

  Future<void> _getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ubah Profil',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF4682A9),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _getImage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Color(0xFF4682A9),
                    width: double.infinity,
                    height: 200.0,
                  ),
                  Positioned(
                    top: 20,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: ClipOval(
                            child: _image != null
                                ? Image.file(
                                    _image!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'images/kpppa_foto_profil.png',
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextField('Nama Lengkap', _namaController),
                  buildTextField('Email', _emailController),
                  buildTextField('Kata Sandi', _passwordController,
                      obscureText: true),
                  buildTextField('Alamat', _alamatController),
                  buildTextField('No Handphone', _noHandphoneController),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
              child: SizedBox(
                width: double.infinity,
                height: 55.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika penyimpanan perubahan di sini
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF4682A9)), // Ubah warna latar belakang
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Ubah nilai sesuai kebutuhan
                      ),
                    ),
                  ),
                  child: Text(
                    'Simpan Perubahan',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: OutlineInputBorder(), // Set border menjadi kotak
              filled: true, // Mengisi latar belakang
              fillColor: Color(0xFFC1D9F1), // Warna latar belakang
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: KPPPAUbahProfile(),
    ));
