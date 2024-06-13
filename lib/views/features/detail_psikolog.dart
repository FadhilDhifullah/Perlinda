import 'package:flutter/material.dart';
import 'bantuan_psikolog.dart';

class DetailPsikolog extends StatelessWidget {
  final String imagePath = 'images/foto_samsul.png';
  final String name = 'Dr. Samsul Arif , M.Psi';
  final String title = 'Psikolog';
  final String description =
      'Dr. Samsul Arif, M.Psi adalah seorang psikolog yang berdedikasi dalam memberikan bantuan psikologis bagi korban Kekerasan Dalam Rumah Tangga (KDRT). Dengan pengalaman klinis lebih dari 15 tahun, Dr. Samsul telah menangani berbagai kasus KDRT dengan pendekatan terapeutik yang holistik dan empatik. Ia memperoleh gelar Doktor dalam Psikologi Klinis dari Universitas Nasional dan memiliki sertifikasi dalam konseling trauma.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        title: Text(
          'Detail Psikolog',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BantuanPsikologPage()),
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0xFF4682A9),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(imagePath),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tentang Saya',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFDAE8FC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
