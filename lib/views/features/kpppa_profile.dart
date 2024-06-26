import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_perlinda/views/features/bantuan_dukungan.dart';
import '../kpppa_home_page.dart';
import '../auth/kpppa_ubah_profile.dart'; // Import UbahProfile page
import '../landing_page.dart'; // Import LandingPage page
import 'kpppa_data_diri.dart'; // Import DataDiri page

class KPPPAProfile extends StatefulWidget {
  const KPPPAProfile({Key? key}) : super(key: key);

  @override
  State<KPPPAProfile> createState() => _KPPPAProfileState();
}

class _KPPPAProfileState extends State<KPPPAProfile> {
  int _selectedIndex = 1; // Index of the selected item
  User? _currentUser;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('kpppa')
          .doc(_currentUser!.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          _userData = userDoc.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch user data: ${e.toString()}'),
        ),
      );
    }
  }

  Future<void> _logout() async {
    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Clear any other user-specific data here if necessary

      // Navigate to LandingPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    } catch (e) {
      // Handle error if any
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during logout: ${e.toString()}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return Scaffold(
        body: Center(
          child: Text('No user is currently logged in.'),
        ),
      );
    }

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
                height: 300.0, // Adjust the height to match the image
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
                    child: _userData != null && _userData!['profile_picture'] != null
                        ? Image.network(
                            _userData!['profile_picture'],
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
              ),
              Positioned(
                top: 170,
                child: Column(
                  children: [
                    SizedBox(height: 12.0),
                    Text(
                      _userData != null ? _userData!['full_name'] : 'Loading...',
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
                                builder: (context) => KPPPAUbahProfile()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)), // Adjust the radius
                        backgroundColor: Color(0xFF00355C), // Adjust the background color
                        fixedSize: Size(224, 55), // Adjust the width and height
                      ),
                      child: Text(
                        'Ubah Profil',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold), // Adjust the text size
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
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to DataDiri page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KPPPADataDiri()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.black), // Add an icon to the left of the text
                      SizedBox(width: 8), // Add a gap between the icon and the text
                      Text(
                        'Data Diri',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                      Icon(Icons.help, color: Colors.black), // Add an icon to the left of the text
                      SizedBox(width: 8), // Add a gap between the icon and the text
                      Text(
                        'Bantuan & Dukungan',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: _logout,
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red), // Add an icon to the left of the text
                      SizedBox(width: 8), // Add a gap between the icon and the text
                      Text(
                        'Keluar',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.red), // Adjust the text color
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
              // Navigate to HomePage
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => KPPPAHomePage()));
            }
          });
        },
      ),
    );
  }
}
