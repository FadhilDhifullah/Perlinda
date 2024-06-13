import 'package:flutter/material.dart';
import 'package:flutter_perlinda/views/features/kpppa_detail_laporan.dart';
import 'package:flutter_perlinda/services/kpppa_report_service.dart';

class KPPPAReportHistories extends StatelessWidget {
  final KPPPAReportService _reportService = KPPPAReportService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4682A9),
        title: Center(
          child: Text(
            "Daftar Laporan Diterima",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _reportService.getReports(),
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
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 400,
                      height: 190,
                      child: Card(
                        color: Color(0xFFC1D9F1),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ID Laporan ${report['id']}',
                                style: TextStyle(
                                  color: Color(0xFF00355C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Judul: ${report['title']}',
                                style: TextStyle(color: Color(0xFF00355C)),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Status: ${report['status']}',
                                style: TextStyle(color: Color(0xFF00355C)),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Pelapor: ${report['reporterName']}',
                                style: TextStyle(color: Color(0xFF00355C)),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            KPPPADetailLaporan(report: report),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF00355C),
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 16.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  child: Text('Lihat Detail'),
                                ),
                              ),
                            ],
                          ),
                        ),
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

void main() => runApp(MaterialApp(
      home: KPPPAReportHistories(),
    ));
