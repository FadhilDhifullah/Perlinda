import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatelessWidget {
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
                  "Emergency Call",
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            EmergencyButton(
              icon: Icons.local_police,
              label: 'Polisi',
              onPressed: () {
                _makePhoneCall('0859191735426');
              },
            ),
            SizedBox(height: 30),
            EmergencyButton(
              icon: Icons.local_hospital,
              label: 'Medis/Ambulans',
              onPressed: () {
                _makePhoneCall('112');
              },
            ),
            SizedBox(height: 30),
            EmergencyButton(
              icon: Icons.person,
              label: 'SAPA/Kemen PPPA',
              onPressed: () {
                _makePhoneCall('123');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }
}

class EmergencyButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const EmergencyButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFC1D9F1),
        foregroundColor: Colors.black,
        minimumSize: Size(double.infinity, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 40),
          SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(fontSize: 18, color: Color(0xFF00355C)),
          ),
        ],
      ),
    );
  }
}
