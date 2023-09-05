import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:payetonkawa/entity/product.dart';
import 'package:payetonkawa/main.dart';
import 'package:payetonkawa/model/product_model.dart';
import 'package:payetonkawa/page/detail_product_page.dart';
import 'package:http/testing.dart';
import 'package:payetonkawa/model/model.dart';
import 'package:get_it/get_it.dart'; // Importer GetIt
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await setup();
  testWidgets('DetailProductPage displays product details',
      (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    // Create a mock client with the desired response
    final mockClient = MockClient((request) async {
      if (request.url.toString() ==
          'http://192.168.1.29:8081/products/1?token=mockToken') {
        return Response(
            '''
          {
            "id": "1",
            "name": "Smartphone",
            "stock": 25,
            "details": {
              "id": 1,
              "price": 250,
              "description": "Produit rouge",
              "color": "red"
            }
          }
        ''',
            200,
            headers: {'content-type': 'application/json'});
      }
      return Response('', 404);
    });

    final productModel = ProductModel(mockClient: mockClient);

    await tester.pumpWidget(MaterialApp(
      home: DetailProductPage(id: '1', mockClient: mockClient),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Smartphone'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('PRIX : 250'), findsOneWidget);
    expect(find.text('Couleur : red'), findsOneWidget);
    expect(find.text('25 pièces'), findsOneWidget);
    expect(find.text('ID du produit : 1'), findsOneWidget);
  });
}
