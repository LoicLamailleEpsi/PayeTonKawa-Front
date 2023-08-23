import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payetonkawa/main.dart';
import 'package:payetonkawa/page/login_page.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() async {
  testWidgets('LoginPage widgets test', (WidgetTester tester) async {
    // Construit le widget LoginPage
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Vérifie si le texte "BIENVENUE SUR L'APPLICATION" est présent
    expect(find.text("BIENVENUE SUR L'APPLICATION"), findsOneWidget);

    // Vérifie si l'image est présente
    expect(find.byType(Image), findsOneWidget);

    // Vérifie si le bouton surélevé (ElevatedButton) est présent
    expect(find.byIcon(Icons.qr_code_2_outlined), findsOneWidget);
  });

  testWidgets('LoginPage Navigation Test', (WidgetTester tester) async {
    // Crée une instance mock de SharedPreferences pour les tests.
    final sharedPreferences = MockSharedPreferences();

    // Enregistre l'instance mock de SharedPreferences avec GetIt pour l'injection de dépendances.
    getIt.registerSingleton<SharedPreferences>(sharedPreferences);

    // Démarre le test de widget en pompant (construisant) le widget MaterialApp avec la page LoginPage comme page d'accueil.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Effectue une pression (simule un clic) sur l'icône du QR Code.
    await tester.tap(find.byIcon(Icons.qr_code_2_outlined));

    // Effectue un pompage et attend que les animations et les transitions de navigation se terminent.
    await tester.pumpAndSettle();

    // Vérifie si le texte attendu "Scannez votre QR Code d'accès" est présent dans l'arbre de widgets.
    expect(find.text("Scannez votre QR Code d'accès"), findsOneWidget);
  });
}
