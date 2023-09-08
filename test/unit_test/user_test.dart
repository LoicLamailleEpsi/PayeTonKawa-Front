
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:payetonkawa/model/model.dart';
import 'package:payetonkawa/model/user_model.dart';

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

void main() async {
  
  group("QRCode testing", () { 

    test('Correct QRCode test', () async {
      //14a8bca529
      String token = "14a8bca529";

      final client = MockClient((request) async {
        if(request.url.toString() != "$baseUrlConnexion/users/getUserByToken" || request.headers["token"] != "14a8bca529"){
          return Response("", 404);
        }
        return Response(jsonUser, 200);
      });

      final UserModel userModel = UserModel(mockClient: client);
      var data1 = await userModel.getUser(token);

      expect(data1.data?.id ?? 0, "4");
      
    });

    test('Invalid QRCode test', () async {
      String token = "fakeqrcodeaaa";

      final client = MockClient((request) async {
        if(request.url.toString() != "$baseUrlConnexion/users/getUserByToken" || request.headers["token"] != "14a8bca529"){
          return Response("", 403);
        }
        return Response(jsonUser, 200);
      });

      final UserModel userModel = UserModel(mockClient: client);
      var data1 = await userModel.getUser(token);

      stdout.writeln(data1.errorMessage);
      expect(errorsMessage.contains(data1.errorMessage), isTrue);
    });
  });

}