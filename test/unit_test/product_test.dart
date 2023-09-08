import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:payetonkawa/main.dart';
import 'package:payetonkawa/model/model.dart';
import 'package:payetonkawa/model/product_model.dart';
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

String jsonListProduct = '[ { "createdAt": "2022-03-07T23:00:00.000+00:00", "name": "Smartphone", "details": { "id": 1.0, "price": 250.0, "description": "Produit roug", "color": "red" }, "stock": 25, "id": 1 }, { "createdAt": "2022-03-07T23:00:00.000+00:00", "name": "Tablette", "details": { "id": 2.0, "price": 500.0, "description": "Produit bleu", "color": "blue" }, "stock": 12, "id": 2 } ]';

void main() async {

  group("Product testing", () {
    test("Product test", () async {
      SharedPreferences.setMockInitialValues({
        idUserPreferenceKey: "14a8bca529"
      });

      WidgetsFlutterBinding.ensureInitialized();
      await setup();

      final client = MockClient((request) async {
        

        if(request.url.toString() != "$baseUrlConnexion/products" || request.headers["token"] != "14a8bca529"){
          return Response("", 403);
        }

        return Response(jsonListProduct, 200, headers: {'content-type': 'application/json'});
      });

      ProductModel productModel = ProductModel(mockClient: client);
      var data = await productModel.getAllProducts();

      expect(data, isNotNull);
      expect(data ?? [], isNotEmpty);
      expect(data!.elementAt(0).stock, isNotNull);
    });
  });

}