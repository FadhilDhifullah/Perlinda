import 'package:flutter/material.dart';
import 'package:flutter_perlinda/views/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showNotification(String message, bool isSuccess) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          color: isSuccess ? Colors.green : Colors.red,
          padding: EdgeInsets.all(16),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(Duration(seconds: 3), () {
      _overlayEntry?.remove();
    });
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        String userId = userCredential.user!.uid;

        // Save user info to Firestore
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'id': userId,
          'full_name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,  // Save password in Firestore
        });

        _showNotification('Yay! Registrasi Berhasil!', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'weak-password') {
          message = 'Ups! Password Terlalu Lemah ! Coba tambahkan lebih banyak karakter, angka, dan simbol untuk membuatnya lebih kuat!';
        } else if (e.code == 'email-already-in-use') {
          message = 'Sepertinya kamu sudah pernah bergabung. Coba login atau gunakan email lain!.';
        } else if (e.code == 'invalid-email') {
          message = 'Format email tidak valid. Pastikan kamu memasukkan email dengan benar.';
        } else if (e.code == 'operation-not-allowed') {
          message = 'Operasi ini tidak diizinkan. Hubungi dukungan untuk bantuan lebih lanjut.';
        } else {
          message = 'Terjadi kesalahan. Silakan coba lagi.';
        }
        _showNotification(message, false);
      } catch (e) {
        _showNotification(e.toString(), false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4682A9),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Stack to overlay logo and circle
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circle
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        width: 247.0,
                        height: 247.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF749BC2),
                        ),
                      ),
                      // Logo
                      Positioned(
                        top: 50.0, // Adjust the top position
                        child: Container(
                          width: 192.0,
                          height: 188.0,
                          child: Image.asset(
                            'images/logo_perlinda.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0), // Spacing

                  // Sign up form with rounded container
                  Container(
                    width: 430.0, // Adjust width as needed
                    height: 600.0, // Adjust height as needed to accommodate the new button
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // "Sign Up" text
                          Center(
                            child: Text(
                              'Buat akun barumu',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0, // Adjust the font size
                                color: Color(0xFF00355C), // Adjust the text color
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0), // Spacing

                          // Nama Lengkap text
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0), // Adjust the left padding
                              child: Text(
                                'Nama Lengkap',
                                style: TextStyle(
                                  fontSize: 16.0, // Adjust the font size
                                  fontWeight: FontWeight.bold, // Make the text bold
                                  color: Color(0xFF00355C), // Adjust the text color
                                ),
                              ),
                            ),
                          ),

                          // SizedBox for spacing between Nama Lengkap text and field
                          SizedBox(height: 12.0),

                          // Nama Lengkap field
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Masukkan nama lengkap',
                              border: InputBorder.none,
                              fillColor: Color(0xFFC1D9F1),
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan nama lengkap anda';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15.0), // Spacing

                          // Alamat Email text
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0), // Adjust the left padding
                              child: Text(
                                'Alamat Email',
                                style: TextStyle(
                                  fontSize: 16.0, // Adjust the font size
                                  fontWeight: FontWeight.bold, // Make the text bold
                                  color: Color(0xFF00355C), // Adjust the text color
                                ),
                              ),
                            ),
                          ),

                          // SizedBox for spacing between Alamat Email text and field
                          SizedBox(height: 12.0),

                          // Alamat Email field
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Masukkan alamat email',
                              border: InputBorder.none,
                              fillColor: Color(0xFFC1D9F1),
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan email anda';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15.0), // Spacing
                          
                          // Kata Sandi text
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0), // Adjust the left padding
                              child: Text(
                                'Kata Sandi',
                                style: TextStyle(
                                  fontSize: 16.0, // Adjust the font size
                                  fontWeight: FontWeight.bold, // Make the text bold
                                  color: Color(0xFF00355C), // Adjust the text color
                                ),
                              ),
                            ),
                          ),
                           SizedBox(height: 12.0),

                          // Kata Sandi field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Masukkan kata sandi',
                              border: InputBorder.none,
                              fillColor: Color(0xFFC1D9F1),
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan kata sandi anda';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 45.0), // Spacing

                          // Sign Up button
                          ElevatedButton(
                            onPressed: _signUp,
                            child: SizedBox(
                              width: 391.0, // Set the width
                              height: 55.0, // Set the height
                              child: Center(
                                child: const Text(
                                  'Buat akun',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4682A9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          InkWell(
                            onTap: () {
                              //Navigasi ke halaman LoginPage
                              Navigator.push(
                                context, MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Text(
                              'Sudah punya akun? Langsung',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ),
                          InkWell(
                            onTap: () {
                              //Navigasi ke halaman LoginPage
                              Navigator.push(
                                context, MaterialPageRoute(builder: (context) => LoginPage())
                              );
                            },
                            child: Text(
                              'Masuk',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // Misalnya, kamu juga bisa menambahkan warna teks atau gaya lainnya di sini
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
