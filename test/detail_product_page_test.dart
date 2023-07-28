import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:payetonkawa/model/product_model.dart';
import 'package:payetonkawa/entity/product.dart';
import 'package:mockito/mockito.dart';

// Création d'un mock pour le httpClient
class MockHttpClient extends Mock implements HttpClient {}

void main() {
  group('ProductModel Tests', () {
    late ProductModel productModel;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      productModel = ProductModel();
    });

    test('getProduct returns a Product when the response is successful', () async {
      // Arrange
      final productId = "some_product_id";
      final jsonResponse = '{"id": "some_product_id", "name": "Product 1", "stock": 10, "details": {"description": "Product Description", "price": "100.00", "color": "Red"}}';
      //when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(jsonResponse, 200));

      // Act
      final product = await productModel.getProduct(productId);

      // Assert
      expect(product, isNotNull);
      expect(product!.id, productId);
      expect(product.name, "Product 1");
      expect(product.stock, 10);
      expect(product.details!.description, "Product Description");
      expect(product.details!.price, "100.00");
      expect(product.details!.color, "Red");
    });

    test('getProduct returns null when the response is not successful', () async {
      // Arrange
      final productId = "some_product_id";
      //when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response('Error', 404));

      // Act
      final product = await productModel.getProduct(productId);

      // Assert
      expect(product, isNull);
    });

    // Ajoutez d'autres tests unitaires pour d'autres méthodes de ProductModel si nécessaire.
  });
}
