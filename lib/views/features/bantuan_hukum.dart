import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_perlinda/services/chat_service.dart';
import 'package:flutter_perlinda/views/features/detail_advokat.dart'; // Sesuaikan dengan path yang benar

class BantuanHukumPage extends StatefulWidget {
  @override
  _BantuanHukumPageState createState() => _BantuanHukumPageState();
}

class _BantuanHukumPageState extends State<BantuanHukumPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
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
      body: SingleChildScrollView(
        child: Padding(
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
              SearchBar(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: MediaQuery.of(context).size.height - 320, // Adjust this value according to your layout
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('advokat').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData) {
                      return Center(child: Text('Tidak ada data'));
                    }

                    final advokatDocs = snapshot.data!.docs;
                    final filteredDocs = advokatDocs.where((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      return data['full_name'].toLowerCase().contains(_searchQuery);
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredDocs.length,
                      itemBuilder: (context, index) {
                        var advokat = filteredDocs[index].data() as Map<String, dynamic>;
                        return LawyerCard(
                          docId: filteredDocs[index].id,
                          imagePath: advokat['image'] ?? 'images/default_avatar.png',
                          name: advokat['full_name'] ?? 'Nama tidak tersedia',
                          phoneNumber: advokat['whatsapp'] ?? 'Nomor tidak tersedia',
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  SearchBar({required this.onChanged});

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
      onChanged: onChanged,
    );
  }
}

class LawyerCard extends StatelessWidget {
  final String docId;
  final String imagePath;
  final String name;
  final String phoneNumber;
  final ChatService _chatService = ChatService();

  LawyerCard({
    required this.docId,
    required this.imagePath,
    required this.name,
    required this.phoneNumber,
  });

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
                MaterialPageRoute(
                  builder: (context) => DetailAdvokat(docId: docId),
                ),
              );
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(imagePath),
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
