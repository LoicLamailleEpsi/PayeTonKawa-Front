// ignore_for_file: unnecessary_new

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:payetonkawa/main.dart';
import 'package:payetonkawa/model/product_model.dart';
import 'package:payetonkawa/model/user_model.dart';
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

String jsonListProduct = '[ { "createdAt": "2022-03-07T23:00:00.000+00:00", "name": "Smartphone", "details": { "id": 1.0, "price": 250.0, "description": "Produit roug", "color": "red" }, "stock": 25, "id": 1 }, { "createdAt": "2022-03-07T23:00:00.000+00:00", "name": "Tablette", "details": { "id": 2.0, "price": 500.0, "description": "Produit bleu", "color": "blue" }, "stock": 12, "id": 2 } ]';
String jsonUser = '{ "id": 4, "username": "alexlbz", "email": "alex.labuz@live.fr", "token": "14a8bca529" }';
List<String> errorsMessage = [
  "Le QRCode n'est pas reconnu",
  "Le service a retourné une erreur",
  "Le delai d'attente à expiré, le serveur api ne donne aucune réponse",
  "Impossible de joindre le serveur api",
  "Connexion impossible, vérifier les réglages réseau du téléphone",
  "Une erreur inconnu sur le réseau est survenu",
  "Une erreur inconnu est survenu"
];

final getIt = GetIt.instance;

Future<void> setup() async{
  getIt.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
}

void main() async {

  group("Product testing", () {
    test("Product test", () async {
      SharedPreferences.setMockInitialValues({
        idUserPreferenceKey: "14a8bca529"
      });

      WidgetsFlutterBinding.ensureInitialized();
      await setup();

      ProductModel productModel = new ProductModel();
      
      MockClient((request) async {
        if(request.url.path != "${productModel.baseUrl}/products?token=14a8bca529"){
          return Response("", 404);
        }

        return Response(jsonListProduct, 200, headers: {'content-type': 'application/json'});
      });

      var data = await productModel.getAllProducts();

      expect(data, isNotNull);
      expect(data ?? [], isNotEmpty);
      expect(data!.elementAt(0).stock, isNotNull);
    });
  });

  group("QRCode testing", () { 

    test('Correct QRCode test', () async {
      //14a8bca529
      String token = "14a8bca529";
      final UserModel _userModel = UserModel();

      MockClient((request) async {
        if(request.url.path != "${_userModel.baseUrl}/users/getUserByToken?token=$token"){
          return Response("", 404);
        }
        return Response(jsonUser, 200);
      });

      var data1 = await _userModel.getUser(token);

      if(data1.data != null){
        expect(data1.data!.id, "4");
      } else if(data1.errorMessage != null){
        stdout.writeln(data1.errorMessage);
        expect(errorsMessage.contains(data1.errorMessage), isTrue);
      }
      
    });

    test('Invalid QRCode test', () async {
      String token = "fakeqrcodeaaa";
      final UserModel _userModel = UserModel();

      MockClient((request) async {
        if(request.url.path != "${_userModel.baseUrl}/users/getUserByToken?token=$token"){
          return Response("", 404);
        }
        return Response(jsonUser, 200);
      });

      var data1 = await _userModel.getUser(token);

      stdout.writeln(data1.errorMessage);
      expect(errorsMessage.contains(data1.errorMessage), isTrue);
    });
  });

}