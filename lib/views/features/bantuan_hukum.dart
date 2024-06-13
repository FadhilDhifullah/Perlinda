import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BantuanHukumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        elevation: 0,
        centerTitle: true, // Center the title
        title: Text(
          'Bantuan Hukum',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF4682A9),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'images/bantuan_hukum.png',
                    height: 120,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Dapatkan bantuan hukum gratis di Perlinda untuk mendukung Anda dalam menghadapi Kekerasan Dalam Rumah Tangga (KDRT). Konsultasi tersedia dengan para profesional kami. Jangan ragu untuk menghubungi kami.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                labelText: 'Cari nama advokat',
                labelStyle: GoogleFonts.poppins(), // Apply Poppins font
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  _buildAdvocateCard(
                    'Gojo Sitorus, M.H',
                    'Advokat',
                    'images/foto_gojo.png',
                  ),
                  _buildAdvocateCard(
                    'Fuad Rusdi, S.H',
                    'Advokat',
                    'images/foto_fuad.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvocateCard(String name, String title, String imagePath) {
    return Card(
      color: Colors.white, // Set background color to white
      margin: EdgeInsets.symmetric(vertical: 8.0), // Add margin between cards
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.black), // Set border color to black
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(imagePath),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              height: 1.0,
              width: double.infinity, // Make the line take full width
              color: Colors.black,
            ),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle chat action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4682A9), // Button color
                ),
                child: Text(
                  'Chat Sekarang',
                  style: GoogleFonts.poppins(
                      color: Colors.white), // Apply Poppins font
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
