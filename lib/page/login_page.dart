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
      /* appBar: AppBar(
        // Titre supprimé
        // title: const Text("BIENVENUE SUR L'APPLICATION PayeTonKawa"),
      ), */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "BIENVENUE SUR L'APPLICATION",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            //const SizedBox(height: 20), // Espace entre le texte et l'image
            Image.asset(
              'assets/png/logo.png', // Remplacez par le chemin de votre image
              width: 350, // Ajustez la largeur selon vos besoins
              height: 350, // Ajustez la hauteur selon vos besoins
              // Vous pouvez également utiliser NetworkImage pour charger une image depuis un URL distant
            ),
            const SizedBox(height: 20), // Espace entre l'image et le bouton
            ElevatedButton(
              onPressed: () {
                // Redirige vers la classe ScanQrCode
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanQrCode()),
                );
              },
              child: const Text('Connexion avec un QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
