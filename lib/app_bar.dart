import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Dashboard', style: TextStyle(fontFamily: 'NightinTokyo')),
      backgroundColor: Color(0xFFCCB69A), // Warna kuah ramen
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (String result) {
            if (result == 'WhatsApp Web Call') {
              _openWhatsAppWeb('Hello, I need assistance!', '628818653880');
            } else if (result == 'WhatsApp Web Message') {
              _openWhatsAppWeb('Hello, I need assistance!', '628818653880');
            } else if (result == 'Maps') {
              _launchMaps('https://www.google.com/maps');
            } else if (result == 'Update User') {
              Navigator.pushNamed(context, '/update-user');
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'WhatsApp Web Call',
              child: Text('WhatsApp Web Call'),
            ),
            const PopupMenuItem<String>(
              value: 'WhatsApp Web Message',
              child: Text('WhatsApp Web Message'),
            ),
            const PopupMenuItem<String>(
              value: 'Maps',
              child: Text('Maps'),
            ),
            const PopupMenuItem<String>(
              value: 'Update User',
              child: Text('Update Profile'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _openWhatsAppWeb(String message, String phone) async {
    final Uri whatsappWebUri = Uri.parse("https://wa.me/$phone?text=${Uri.encodeComponent(message)}");
    if (await canLaunch(whatsappWebUri.toString())) {
      await launch(whatsappWebUri.toString());
    } else {
      throw 'Could not launch WhatsApp Web';
    }
  }

  Future<void> _launchMaps(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Maps';
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}