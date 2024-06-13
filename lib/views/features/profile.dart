import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_perlinda/views/features/bantuan_dukungan.dart';
import '../home_page.dart';
import '../auth/ubah_profile.dart'; // Import UbahProfile page
import '../landing_page.dart'; // Import LandingPage page
import 'data_diri.dart'; // Import DataDiri page

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 1; // Index of the selected item
  final User? user = FirebaseAuth.instance.currentUser;
  String _fullName = '';
  String? _profilePictureUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      if (userData.exists) {
        setState(() {
          _fullName = userData['full_name'];
          _profilePictureUrl = userData['profile_picture'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back button
        title: Text(
          'Profil',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF4682A9),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Color(0xFF4682A9),
                height: 300.0, // Sesuaikan tinggi container
              ),
              Positioned(
                top: 20,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipOval(
                    child: _profilePictureUrl != null
                        ? Image.network(
                            _profilePictureUrl!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.account_circle,
                            size: 120,
                            color: Colors.grey,
                          ),
                  ),
                ),
              ),
              Positioned(
                top: 170,
                child: Column(
                  children: [
                    SizedBox(height: 12.0),
                    Text(
                      _fullName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to UbahProfile page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UbahProfile()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8)), // Sesuaikan radius
                        backgroundColor:
                            Color(0xFF00355C), // Sesuaikan warna latar belakang
                        fixedSize: Size(224, 55), // Sesuaikan lebar dan tinggi
                      ),
                      child: Text(
                        'Ubah Profil',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold), // Sesuaikan ukuran teks
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Teks rata kiri
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to DataDiri page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DataDiri()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.person,
                          color: Colors
                              .black), // Tambahkan ikon di samping kiri teks
                      SizedBox(width: 8), // Berikan jarak antara ikon dan teks
                      Text(
                        'Data Diri',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    // Navigate to DukunganBantuan page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BantuanDukungan()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.help,
                          color: Colors
                              .black), // Tambahkan ikon di samping kiri teks
                      SizedBox(width: 8), // Berikan jarak antara ikon dan teks
                      Text(
                        'Bantuan & Dukungan',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    // Navigate to LandingPage
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LandingPage()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.logout,
                          color: Colors
                              .red), // Tambahkan ikon di samping kiri teks
                      SizedBox(width: 8), // Berikan jarak antara ikon dan teks
                      Text(
                        'Keluar',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.red), // Sesuaikan warna teks
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue, // Color of selected item
        unselectedItemColor: Colors.white,
        backgroundColor: Color(0xFF00355C), // Color of unselected item
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 0) {
              // Navigasi ke halaman Home
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            }
          });
        },
      ),
    );
  }
}
