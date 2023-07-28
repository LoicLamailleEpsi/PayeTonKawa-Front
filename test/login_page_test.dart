import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payetonkawa/page/login_page.dart';
import 'package:payetonkawa/page/scan_qr_code_page.dart';

void main() async {
  /* WidgetsFlutterBinding.ensureInitialized();
  await setup(); */

  testWidgets('LoginPage widgets test', (WidgetTester tester) async {
    // Build the LoginPage widget
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Verify if the "BIENVENUE SUR L'APPLICATION" text is present
    expect(find.text("BIENVENUE SUR L'APPLICATION"), findsOneWidget);

    // Verify if the image is present
    expect(find.byType(Image), findsOneWidget);

    // Verify if the ElevatedButton is present
    expect(find.byIcon(Icons.qr_code_2_outlined), findsOneWidget);
  });

  testWidgets('LoginPage Navigation Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Tap the ElevatedButton to open the QRCode page.
    await tester.tap(find.byIcon(Icons.qr_code_2_outlined));
    await tester
        .pumpAndSettle(); // Wait for navigation and animations to complete.

    expect(find.byType(ScanQrCodePage), findsOneWidget);
  }); 
}
