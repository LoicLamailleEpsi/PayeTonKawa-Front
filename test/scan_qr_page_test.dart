import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:payetonkawa/entity/user.dart';
import 'package:payetonkawa/page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:payetonkawa/page/scan_qr_code_page.dart';
import 'package:payetonkawa/model/user_model.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/foundation.dart';

// Définition des classes de mock
class MockSharedPreferences extends Mock implements SharedPreferences {}
class MockMobileScannerController extends Mock implements MobileScannerController {}
class MockUserModel extends Mock implements UserModel {}

void main() {
  group('ScanQrCodePage', () {
    late MockSharedPreferences mockSharedPreferences;
    late MockMobileScannerController mockScannerController;
    late MockUserModel mockUserModel;
    late ScanQrCodePage scanQrCodePage;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      mockScannerController = MockMobileScannerController();
      mockUserModel = MockUserModel();

      GetIt.instance
          .registerSingleton<SharedPreferences>(mockSharedPreferences);
      GetIt.instance
          .registerSingleton<MobileScannerController>(mockScannerController);
      GetIt.instance.registerSingleton<UserModel>(mockUserModel);

      scanQrCodePage = ScanQrCodePage();
    });

    tearDown(() {
      GetIt.instance.reset();
    });

    testWidgets('ScanQrCodePage widgets tests', (WidgetTester tester) async {
      // Construit notre application et déclenche une mise à jour de la fenêtre.
      await tester.pumpWidget(MaterialApp(home: scanQrCodePage));

      // Vérifie si le texte 'Scannez votre QR Code d'accès' est présent dans l'arbre des widgets.
      expect(find.text('Scannez votre QR Code d\'accès'), findsOneWidget);

      // Vérifie si un widget de type MobileScanner est présent dans l'arbre des widgets.
      expect(find.byType(MobileScanner), findsOneWidget);
    });

    testWidgets('ScanQrCodePage debug button test',
        (WidgetTester tester) async {
      // Construit notre application et déclenche une mise à jour de la fenêtre.
      when(mockUserModel.getUser('METTRE VRAI TOKEN ICI')).thenAnswer((_) async => DataResult<User>(
        data: User(token: 'METTRE VRAI TOKEN ICI'),
        errorMessage: null,
      ));
      await tester.pumpWidget(MaterialApp(home: scanQrCodePage));

      // Appelle le bouton de débogage
      await tester.tap(find.text('debug login'));
      await tester.pumpAndSettle();

      // Vérifie si la page HomePage a été ouverte après le débogage
      expect(find.byType(HomePage), findsOneWidget);

      // Vérifie si la méthode dispose a été appelée sur le contrôleur de scanner
      verify(mockScannerController.dispose()).called(1);
    });
  });
}
