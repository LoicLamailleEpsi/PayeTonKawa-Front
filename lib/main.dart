import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payetonkawa/page/home_page.dart';
import 'package:payetonkawa/page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async{
  getIt.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
}

bool isEmulator = false;
String idUserPreferenceKey = "idUserPreferenceKey";

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
      home: getIt<SharedPreferences>().getString(idUserPreferenceKey) == null ? const LoginPage() : const HomePage(),
    );
  }
}
