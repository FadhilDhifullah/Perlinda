import 'package:flutter/material.dart';
import 'package:flutter_perlinda/views/features/detail_psikolog.dart';

import 'chat_psikolog.dart';

class BantuanPsikologPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        title: Text(
          'Bantuan Psikolog',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xFF4682A9),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Image.asset('images/bantuan_psikolog_ilustrasi.png'),
                SizedBox(height: 16),
                Text(
                  'Dapatkan bantuan psikologis di Perlinda untuk mendukung Anda dalam menghadapi Kekerasan Dalam Rumah Tangga (KDRT). Konsultasi tersedia dengan para profesional kami. Jangan ragu untuk menghubungi kami.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                SearchBar(),
                SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: ListView(
                children: [
                  LawyerCard(
                    imagePath: 'images/foto_samsul.png',
                    name: 'Dr. Samsul Arif , M.Psi',
                  ),
                  SizedBox(height: 16),
                  LawyerCard(
                    imagePath: 'images/foto_afreya.png',
                    name: 'Dr. Afreya, M.Psi',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari nama psikolog',
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

  LawyerCard({required this.imagePath, required this.name});

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
                MaterialPageRoute(builder: (context) => DetailPsikolog()),
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
                    Text('Psikolog'),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPsikolog()),
                  );
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
