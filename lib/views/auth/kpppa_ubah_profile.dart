import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class KPPPAUbahProfile extends StatefulWidget {
  const KPPPAUbahProfile({Key? key}) : super(key: key);

  @override
  State<KPPPAUbahProfile> createState() => _KPPPAUbahProfileState();
}

class _KPPPAUbahProfileState extends State<KPPPAUbahProfile> {
  File? _image;
  String? _imageUrl;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noHandphoneController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      final userData = await FirebaseFirestore.instance.collection('kpppa').doc(user!.uid).get();
      if (userData.exists) {
        setState(() {
          _namaController.text = userData['full_name'] ?? '';
          _emailController.text = userData['email'] ?? '';
          _alamatController.text = userData['alamat'] ?? '';
          _noHandphoneController.text = userData['no_handphone'] ?? '';
          _passwordController.text = '********'; // Mask the password
          _imageUrl = userData['profile_picture'];
        });
      }
    }
  }

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      try {
        final ref = FirebaseStorage.instance.ref().child('profile_pictures_kpppa').child('${user!.uid}.jpg');
        await ref.putFile(_image!);
        _imageUrl = await ref.getDownloadURL();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengunggah gambar: $e')),
        );
      }
    }
  }

  Future<void> _saveChanges() async {
    if (user != null) {
      try {
        await _uploadImage();

        await FirebaseFirestore.instance.collection('kpppa').doc(user!.uid).update({
          'full_name': _namaController.text,
          'email': _emailController.text,
          'alamat': _alamatController.text,
          'no_handphone': _noHandphoneController.text,
          'profile_picture': _imageUrl,
        });

        // Optionally, update the email and password in FirebaseAuth
        if (_emailController.text != user!.email) {
          await user!.updateEmail(_emailController.text);
        }
        if (_passwordController.text.isNotEmpty && _passwordController.text != '********') {
          await user!.updatePassword(_passwordController.text);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Perubahan berhasil disimpan')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan perubahan: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User tidak ditemukan. Silakan login kembali.')),
      );
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
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                              : (_imageUrl != null
                                  ? Image.network(
                                      _imageUrl!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.account_circle,
                                      size: 120,
                                      color: Colors.grey,
                                    )),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: ElevatedButton(
                          onPressed: _getImage,
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(8),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
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
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextField('Nama Lengkap', _namaController, 'Masukkan nama lengkap'),
                  buildTextField('Email', _emailController, 'Masukkan email', readOnly: true),
                  buildTextField('Kata Sandi', _passwordController, 'Masukkan kata sandi', obscureText: true, readOnly: true),
                  buildTextField('Alamat', _alamatController, 'Masukkan alamat'),
                  buildTextField('No Handphone', _noHandphoneController, 'Masukkan no handphone'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
              child: SizedBox(
                width: double.infinity,
                height: 55.0,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4682A9)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
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

  Widget buildTextField(String labelText, TextEditingController controller, String placeholder, {bool obscureText = false, bool readOnly = false}) {
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
            readOnly: readOnly,
            decoration: InputDecoration(
              hintText: placeholder,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFFC1D9F1),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: KPPPAUbahProfile(),
  ));
}
