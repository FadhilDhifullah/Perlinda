import 'package:flutter/material.dart';
import 'package:flutter_perlinda/services/report_history_service.dart';
import 'package:flutter_perlinda/views/features/report_history_details.dart';

class ReportHistory extends StatelessWidget {
  final ReportHistoryService _reportHistoryService = ReportHistoryService();

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
                  "Riwayat Laporan",
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
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _reportHistoryService.getReportsByUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Tidak ada laporan'));
            } else {
              final reports = snapshot.data!;
              return ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return Card(
                    color: Color(0xFFC1D9F1),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        'ID Laporan ${report['id']}',
                        style: TextStyle(
                          color: Color(0xFF00355C),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: Text(
                        report['title'] ?? 'No Title',
                        style: TextStyle(color: Color(0xFF00355C)),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Navigasi ke DetailRiwayatLaporan
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRiwayatLaporan(
                                reportId: report['id'],
                                reportData: report,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color(0xFF00355C), // Warna latar belakang tombol
                          foregroundColor: Colors.white, // Warna teks tombol
                          padding: EdgeInsets.symmetric(
                            vertical: 18.0,
                            horizontal: 20.0,
                          ), // Menambah tinggi tombol
                        ),
                        child: Text('Lihat Riwayat'),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
