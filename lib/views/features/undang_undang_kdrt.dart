import 'package:flutter/material.dart';

class UUDKDRTPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        title: Text(
          'Undang - Undang KDRT',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Undang-Undang Nomor 23 Tahun 2004 tentang Penghapusan Kekerasan dalam Rumah Tangga (UU PKDRT)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'UU PKDRT adalah peraturan perundang-undangan di Indonesia yang secara khusus mengatur tentang pencegahan dan penanggulangan Kekerasan Dalam Rumah Tangga (KDRT).',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tujuan UU PKDRT:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Mencegah terjadinya KDRT'),
            _buildBulletPoint('Menindak pelaku KDRT'),
            _buildBulletPoint('Melindungi korban KDRT'),
            SizedBox(height: 16),
            Text(
              'UU PKDRT mengatur tentang:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Definisi KDRT'),
            _buildBulletPoint('Bentuk-bentuk KDRT'),
            _buildBulletPoint('Hak korban KDRT'),
            _buildBulletPoint('Kewajiban pelaku KDRT'),
            _buildBulletPoint('Upaya pencegahan KDRT'),
            _buildBulletPoint('Penanganan korban KDRT'),
            _buildBulletPoint('Perlindungan korban KDRT'),
            _buildBulletPoint('Sanksi pidana bagi pelaku KDRT'),
            SizedBox(height: 16),
            Text(
              'Menurut UU PKDRT, KDRT dapat berbentuk:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildBulletPoint(
                'Kekerasan fisik, seperti pemukulan, penganiayaan, dan pembunuhan'),
            _buildBulletPoint(
                'Kekerasan seksual, seperti pemerkosaan, pelecehan seksual, dan penyiksaan seksual'),
            _buildBulletPoint(
                'Kekerasan psikologis, seperti penghinaan, pelecehan verbal, dan intimidasi'),
            _buildBulletPoint(
                'Penelantaran ekonomi, seperti pengabaian kebutuhan hidup korban'),
            _buildBulletPoint(
                'Kekerasan psikis, seperti penguntitan, perusakan harta benda, dan ancaman'),
            SizedBox(height: 16),
            Text(
              'Korban KDRT berhak atas:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Perlindungan dari KDRT'),
            _buildBulletPoint('Bantuan hukum'),
            _buildBulletPoint('Rehabilitasi medis dan psikososial'),
            _buildBulletPoint('Santunan'),
            _buildBulletPoint('Kemudahan akses terhadap layanan publik'),
            SizedBox(height: 16),
            Text(
              'Kewajiban Pelaku KDRT:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Menghentikan KDRT'),
            _buildBulletPoint('Mengganti kerugian korban'),
            _buildBulletPoint('Mengikuti program rehabilitasi'),
            SizedBox(height: 16),
            Text(
              'Upaya Pencegahan KDRT:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Penyuluhan tentang KDRT'),
            _buildBulletPoint('Pembinaan keluarga'),
            _buildBulletPoint('Penguatan peran perempuan'),
            _buildBulletPoint('Penegakan hukum yang tegas'),
            SizedBox(height: 16),
            Text(
              'Penanganan Korban KDRT:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Pemberian bantuan medis dan psikososial'),
            _buildBulletPoint('Pendampingan hukum'),
            _buildBulletPoint('Pemberian tempat penampungan sementara'),
            SizedBox(height: 16),
            Text(
              'Perlindungan Korban KDRT:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Pemberian identitas baru'),
            _buildBulletPoint('Rahasia identitas korban'),
            _buildBulletPoint('Pengamanan korban'),
            SizedBox(height: 16),
            Text(
              'Sanksi Pidana Bagi Pelaku KDRT:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Pelaku KDRT dapat dipidana dengan pidana penjara paling lama 15 tahun dan denda paling banyak Rp 450 juta.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UUDKDRTPage(),
  ));
}
