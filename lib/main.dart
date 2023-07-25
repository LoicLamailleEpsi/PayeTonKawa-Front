import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payetonkawa/page/login_page.dart';

void main() {
  runApp(const MyApp());
}

bool isEmulator = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paye Ton Kawa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF453510)),
        useMaterial3: true,
        textTheme: GoogleFonts.jostTextTheme(),
      ),
      home: const LoginPage(),
    );
  }
}
