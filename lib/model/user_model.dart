// ignore_for_file: dead_code

import 'dart:convert';

import 'package:payetonkawa/entity/user.dart';
import 'package:payetonkawa/model/model.dart';

class UserModel extends Model {
  
  Future<User?> getUser(String token) async {
    try {
      var url = Uri.parse("$baseUrl/user/?token=\"$token\"");
      var response = await httpClient.get(url);

      //Map<String, dynamic> u = jsonDecode('{"id": "abc","email":"alex@hotmail.fr","username":"Alex", "token": "abcdef"}');
      //return User.fromJson(u);
        
      if(response.statusCode == 200){
        Map<String, dynamic> u = jsonDecode(response.body);
        return User.fromJson(u);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

}