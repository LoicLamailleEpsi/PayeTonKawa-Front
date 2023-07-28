import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:payetonkawa/main.dart';
import 'package:payetonkawa/page/home_page.dart';
import 'package:payetonkawa/page/scan_qr_code_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ScanQrCodePage', () {
    // Helper function to build the ScanQrCodePage with a MaterialApp
    Future<void> _buildScanQrCodePage(WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({}); // Mock SharedPreferences
      await tester.pumpWidget(MaterialApp(home: ScanQrCodePage()));
    }

    testWidgets('ScanQrCodePage has an app bar', (WidgetTester tester) async {
      await _buildScanQrCodePage(tester);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('ScanQrCodePage shows CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      await _buildScanQrCodePage(tester);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Simulate QR code detection, which triggers loading
      await tester.tap(find.byType(MobileScanner));
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Veuillez patienter ...'), findsOneWidget);

      // Simulate QR code detection finished, loading should be hidden
      await tester.tap(find.byType(MobileScanner));
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('ScanQrCodePage shows error dialog when QR code is invalid',
        (WidgetTester tester) async {
      await _buildScanQrCodePage(tester);

      // Simulate QR code detection with invalid QR code
      await tester.tap(find.byType(MobileScanner));
      await tester.pumpAndSettle();
      expect(find.text("Erreur de connexion"), findsNothing);

      // Simulate invalid QR code detected
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(idUserPreferenceKey, "invalid_token");
      await tester.tap(find.byType(MobileScanner));
      await tester.pumpAndSettle();
      expect(find.text("Erreur de connexion"), findsOneWidget);

      // Tap "Fermer" button in the dialog
      await tester.tap(find.text("Fermer"));
      await tester.pumpAndSettle();
      expect(find.text("Erreur de connexion"), findsNothing);
    });

    testWidgets('ScanQrCodePage navigates to HomePage when QR code is valid',
        (WidgetTester tester) async {
      await _buildScanQrCodePage(tester);

      // Simulate QR code detection with valid QR code
      await tester.tap(find.byType(MobileScanner));
      await tester.pumpAndSettle();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(idUserPreferenceKey, "valid_token");
      await tester.tap(find.byType(MobileScanner));
      await tester.pumpAndSettle();

      // Verify navigation to HomePage
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('ScanQrCodePage debug button should be hidden in release mode',
        (WidgetTester tester) async {
      await _buildScanQrCodePage(tester);
      expect(find.text("debug login"), findsNothing);
    });

    testWidgets('ScanQrCodePage debug button should be visible in debug mode',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      await _buildScanQrCodePage(tester);
      debugDefaultTargetPlatformOverride = null; // Reset debug mode

      expect(find.text("debug login"), findsOneWidget);

      // Tap debug button and verify navigation to HomePage
      await tester.tap(find.text("debug login"));
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
