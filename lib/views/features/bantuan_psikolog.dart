import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_perlinda/services/chat_service.dart';
import 'package:flutter_perlinda/views/features/detail_psikolog.dart';

class BantuanPsikologPage extends StatefulWidget {
  @override
  _BantuanPsikologPageState createState() => _BantuanPsikologPageState();
}

class _BantuanPsikologPageState extends State<BantuanPsikologPage> {
  String _searchQuery = '';

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
                SearchBar(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('psikolog')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text('Tidak ada data'));
                  }

                  final psikologDocs = snapshot.data!.docs;
                  final filteredDocs = psikologDocs.where((doc) {
                    var data = doc.data() as Map<String, dynamic>;
                    return data['full_name']
                        .toLowerCase()
                        .contains(_searchQuery);
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      var psikolog =
                          filteredDocs[index].data() as Map<String, dynamic>;
                      return PsychologistCard(
                        docId: filteredDocs[index].id,
                        imagePath:
                            psikolog['image'] ?? 'images/default_avatar.png',
                        name: psikolog['full_name'] ?? 'Nama tidak tersedia',
                        phoneNumber:
                            psikolog['whatsapp'] ?? 'Nomor tidak tersedia',
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
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
      onChanged: onChanged,
    );
  }
}

class PsychologistCard extends StatelessWidget {
  final String docId;
  final String imagePath;
  final String name;
  final String phoneNumber;
  final ChatService _chatService = ChatService();

  PsychologistCard({
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
                  builder: (context) => DetailPsikolog(docId: docId),
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
