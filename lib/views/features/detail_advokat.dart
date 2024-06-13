import 'package:flutter/material.dart';
import 'bantuan_hukum.dart';

class DetailAdvokat extends StatelessWidget {
  final String imagePath = 'images/foto_gojo.png';
  final String name = 'Gojo Sitorus, M.H';
  final String title = 'Advokat';
  final String description =
      'Gojo Sitorus adalah seorang advokat berpengalaman yang memiliki spesialisasi dalam penanganan kasus Kekerasan Dalam Rumah Tangga (KDRT). '
      'Dengan lebih dari sepuluh tahun pengalaman di bidang hukum, Gojo telah berhasil membela hak-hak korban KDRT dan memberikan bantuan hukum yang diperlukan untuk melindungi klien-kliennya. '
      'Ia memegang gelar sarjana hukum dari Universitas Nasional dan telah mengikuti berbagai pelatihan dan seminar terkait KDRT serta hukum keluarga.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        title: Text(
          'Detail Advokat',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BantuanHukumPage()),
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
