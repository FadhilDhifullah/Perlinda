import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_perlinda/services/chat_service.dart';
import 'package:flutter_perlinda/views/features/detail_advokat.dart'; // Sesuaikan dengan path yang benar

class BantuanHukumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        elevation: 0,
        centerTitle: true,
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
            SearchBar(),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  LawyerCard(
                    imagePath: 'images/foto_gojo.png',
                    name: 'Gojo Sitorus, M.H',
                    phoneNumber: '0859191735426', // Nomor WhatsApp pertama
                  ),
                  SizedBox(height: 16),
                  LawyerCard(
                    imagePath: 'images/foto_fuad.png',
                    name: 'Fuad Rusdi, S.H',
                    phoneNumber: '082140830811', // Nomor WhatsApp kedua
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari nama advokat',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

class LawyerCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String phoneNumber;
  final ChatService _chatService = ChatService();

  LawyerCard(
      {required this.imagePath, required this.name, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 205,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailAdvokat()),
              );
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(imagePath),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Advokat'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  _chatService.openWhatsAppChat(phoneNumber);
                },
                child: Text(
                  'Chat Sekarang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4682A9),
                  fixedSize: Size(160, 49),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
