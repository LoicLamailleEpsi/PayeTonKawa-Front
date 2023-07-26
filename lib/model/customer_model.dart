import 'dart:convert';

import 'package:payetonkawa/entity/customer.dart';
import 'package:payetonkawa/model/model.dart';

class CustomerModel extends Model {
  
  Future<Customer?> getCustomer(String id) async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // TODO : a retirer quand API implémenté
      var url = Uri.parse("$baseUrl/customer/$id");
      var response = await httpClient.get(url);

      if(response.statusCode == 200){
        Map<String, dynamic> c = jsonDecode(response.body);
        return Customer.fromJson(c);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

}