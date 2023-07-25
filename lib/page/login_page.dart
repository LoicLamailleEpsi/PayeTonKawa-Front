import 'package:flutter/material.dart';
import 'package:payetonkawa/page/scan_qr_code.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BIENVENUE SUR L'APPLICATION PayeTonKawa"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Redirige vers la classe ScanQrCode
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScanQrCode()),
            );
          },
          child: Text('Connexion avec un QR Code'),
        ),
      ),
    );
  }
}
