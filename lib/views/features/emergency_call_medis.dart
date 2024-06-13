import 'package:flutter/material.dart';

class EmergencyCallMedis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Telepon Darurat Medis/Ambulans",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 48), // To balance the space taken by IconButton
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lokasi',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF4682A9)),
            ),
            Text(
              'Otomatis mendeteksi GPS anda',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.map,
                  size: 100,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Pesan Darurat',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF4682A9)),
            ),
            SizedBox(height: 8),
            Container(
              height: 137,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Color(0xFFC1D9F1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLines:
                          null, // Allows the TextField to expand vertically
                      expands:
                          true, // Ensures the TextField expands to fill its parent
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Ketik Pesan Darurat',
                      ),
                    ),
                  ),
                  // Menggunakan Align untuk menjadikan ikon sejajar dengan teks
                  Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        // Action to send emergency message
                      },
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[100],
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Action to cancel emergency call
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Batalkan Panggilan Darurat',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.close, color: Colors.black),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
