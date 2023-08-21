// ignore_for_file: dead_code

import 'dart:convert';
import 'dart:io';

import 'package:payetonkawa/entity/user.dart';
import 'package:payetonkawa/model/model.dart';

class UserModel extends Model {
  
  Future<DataResult<User>> getUser(String token) async {
    try {
      var url = Uri.parse("$baseUrl/users/getUserByToken?token=$token");
      var response = await httpClient.get(url);

      //Map<String, dynamic> u = jsonDecode('{"id": "abc","email":"alex@hotmail.fr","username":"Alex", "token": "abcdef"}');
      //return User.fromJson(u);

      if(response.statusCode == 403) {
        return DataResult(errorMessage: "Le QRCode n'est pas reconnu");
      }

      if(response.statusCode != 200){
        return DataResult(errorMessage: "Le service a retourné une erreur ${response.statusCode}");
      }
      
      Map<String, dynamic> u = jsonDecode(response.body);
      return DataResult(data: User.fromJson(u));
      
    } on SocketException catch (e) {
      if(e.message == "Connection timed out"){
        return DataResult(errorMessage: "Le delai d'attente à expiré, le serveur api ne donne aucune réponse");
      }
      if(e.message == "No route to host"){
        return DataResult(errorMessage: "Impossible de joindre le serveur api");
      }
      if(e.message == "Connection failed"){
        return DataResult(errorMessage: "Connexion impossible, vérifier les réglages réseau du téléphone");
      }
      return DataResult(errorMessage: "Une erreur inconnu sur le réseau est survenu");
    } catch (e){
      return DataResult(errorMessage: "Une erreur inconnu est survenu");
    }
  }

}

class DataResult<T> {
  T? data;
  String? errorMessage;

  DataResult({this.data, this.errorMessage});
}