import 'package:flutter/material.dart';
import 'package:flutter_perlinda/views/features/kpppa_profile.dart';
import 'package:flutter_perlinda/views/features/kpppa_daftar_laporan.dart';
import 'package:flutter_perlinda/views/features/kpppa_riwayat_laporan.dart';

class KPPPAHomePage extends StatefulWidget {
  const KPPPAHomePage({Key? key}) : super(key: key);

  @override
  State<KPPPAHomePage> createState() => _KPPPAHomePageState();
}

class _KPPPAHomePageState extends State<KPPPAHomePage> {
  int _selectedIndex = 0; // Index of the selected item

  final List<String> titles = [
    'Lihat Laporan',
    'Riwayat Laporan',
  ];

  final List<String> images = [
    'images/lihat_laporan.png',
    'images/riwayat_laporan.png',
  ];

  // Function to handle navigation item selection
  void _onBottomNavTapped(int index) {
    setState(() {
      if (index == 0) {
        // If Home is pressed, do nothing
        _selectedIndex = index;
      } else if (index == 1) {
        // If Profile is pressed, navigate to the profile page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KPPPAProfile()),
        );
      }
    });
  }

  // Function to handle grid item taps
  void _onGridItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KPPPAReportHistories()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KPPPAReportList()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header with custom image and logo
            Container(
              width: double.infinity,
              height: 150.0, // Adjust height as needed
              child: Stack(
                children: [
                  Image.asset(
                    'images/logo_home.png', // Replace with your header background image
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150.0,
                  ),
                  Positioned(
                    top: 16.0,
                    left: 16.0,
                    child: Image.asset(
                      'images/logo_perlinda.png',
                      width: 50.0, // Adjust the width as needed
                      height: 50.0, // Adjust the height as needed
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 1.0), // Spacing

            // Greeting text
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Semoga harimu baik, Meilin!',
                style: TextStyle(
                  color: Color(0xFF00355C),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0), // Spacing

            // Grid of 2 boxes
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _onGridItemTapped(index); // Handle item tap
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFD9E6F2),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(
                                images[index],
                                width: 30.0, // Adjust the width as needed
                                height: 30.0, // Adjust the height as needed
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              titles[index],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00355C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
