// Importation des bibliothèques nécessaires pour les tests Flutter.
import 'package:flutter_test/flutter_test.dart';
import 'package:payetonkawa/page/home_page.dart';


// Définition de la fonction principale du test.
void main() {
  // Assure l'initialisation des widgets Flutter pour les tests.
  TestWidgetsFlutterBinding.ensureInitialized();

  // Création d'un groupe de tests pour la page HomePage.
  group('HomePage', () {
    // Déclaration différée (late) de la variable homePage de type HomePage.
    late HomePage homePage;

    // Configuration exécutée avant chaque test dans ce groupe.
    setUp(() {
      // Initialisation de la variable homePage en créant une instance de HomePage.
      homePage = HomePage();
    });

    // Test : Vérification de l'état initial de la page.
    test('État initial', () {
      // Vérifie que la valeur de la variable openPage dans homePage est égale à 0.
      expect(homePage.openPage, 0);

      // Vérifie que la valeur de la variable titlePage dans homePage est égale à 'Paye Ton Kawa'.
      expect(homePage.titlePage, 'Paye Ton Kawa');

      // Vérifie que la variable user dans homePage est nulle.
      expect(homePage.user, isNull);
    });

  });
}
