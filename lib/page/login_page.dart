import 'package:flutter/material.dart';
import 'package:payetonkawa/page/scan_qr_code_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void _openQRCode(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScanQrCodePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "BIENVENUE SUR L'APPLICATION",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              'assets/png/logo.png',
              width: 350,
              height: 350,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _openQRCode(),
              child: const Text('Connexion avec un QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
