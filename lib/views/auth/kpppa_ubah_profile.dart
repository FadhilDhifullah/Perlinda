import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  String? _userId;
  String? _dataDiriId;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });

      // Fetch the data from the kpppa collection
      DocumentSnapshot kpppaDoc = await FirebaseFirestore.instance
          .collection('kpppa')
          .doc(user.uid)
          .get();
      if (kpppaDoc.exists) {
        setState(() {
          _namaController.text = kpppaDoc['full_name'] ?? '';
          _emailController.text = kpppaDoc['email'] ?? '';
        });

        // Check if there's an existing document in kpppaDataDiri
        QuerySnapshot dataDiriSnapshot = await FirebaseFirestore.instance
            .collection('kpppaDataDiri')
            .where('id_kpppa', isEqualTo: kpppaDoc['id_kpppa'])
            .get();

        if (dataDiriSnapshot.docs.isNotEmpty) {
          DocumentSnapshot dataDiriDoc = dataDiriSnapshot.docs.first;
          setState(() {
            _dataDiriId = dataDiriDoc.id;
            _alamatController.text = dataDiriDoc['address'] ?? '';
            _noHandphoneController.text = dataDiriDoc['phone'] ?? '';
            _profileImageUrl = dataDiriDoc['profile_image'];
          });
        }
      }
    }
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

  Future<void> _saveChanges() async {
    if (_userId == null) return;

    String? imageUrl;
    if (_image != null) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('profile_images/$_userId.jpg')
          .putFile(_image!);
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
    }

    Map<String, dynamic> data = {
      'full_name': _namaController.text,
      'email': _emailController.text,
      'address': _alamatController.text,
      'phone': _noHandphoneController.text,
      if (imageUrl != null) 'profile_image': imageUrl,
      'id_kpppa': (await FirebaseFirestore.instance
          .collection('kpppa')
          .doc(_userId)
          .get())['id_kpppa'],
    };

    if (_dataDiriId == null) {
      DocumentReference newDoc = await FirebaseFirestore.instance
          .collection('kpppaDataDiri')
          .add(data);
      _dataDiriId = newDoc.id;
    } else {
      await FirebaseFirestore.instance
          .collection('kpppaDataDiri')
          .doc(_dataDiriId)
          .update(data);
    }

    // Optionally, update the email and password in FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (_emailController.text != user.email) {
        await user.updateEmail(_emailController.text);
      }
      if (_passwordController.text.isNotEmpty) {
        await user.updatePassword(_passwordController.text);
      }
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Profile updated successfully')));
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
      body: FutureBuilder(
        future: _loadUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
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
                                      : (_profileImageUrl != null
                                          ? Image.network(
                                              _profileImageUrl!,
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              color: Colors.grey[200],
                                              width: 120,
                                              height: 120,
                                            )),
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
                    padding:
                        EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextField('Nama Lengkap', _namaController,
                            'Masukkan nama lengkap'),
                        buildTextField(
                            'Email', _emailController, 'Masukkan email'),
                        buildTextField('Kata Sandi', _passwordController,
                            'Masukkan kata sandi',
                            obscureText: true),
                        buildTextField(
                            'Alamat', _alamatController, 'Masukkan alamat'),
                        buildTextField('No Handphone', _noHandphoneController,
                            'Masukkan no handphone'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 50.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55.0,
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF4682A9)), // Ubah warna latar belakang
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
            );
          }
        },
      ),
    );
  }

  Widget buildTextField(
      String labelText, TextEditingController controller, String placeholder,
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
              hintText: placeholder,
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
