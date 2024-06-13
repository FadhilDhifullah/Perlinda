import 'package:url_launcher/url_launcher.dart';

class ChatService {
  void openWhatsAppChat(String phoneNumber) async {
    final whatsappUrl = 'https://wa.me/$phoneNumber';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
