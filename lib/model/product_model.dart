import 'dart:convert';

import 'package:payetonkawa/entity/product.dart';
import 'package:payetonkawa/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ProductModel extends Model {
  late String? token;
  
  ProductModel(){
    token = getIt<SharedPreferences>().getString(idUserPreferenceKey);
  }

  Future<List<Product>?> getAllProducts() async {
    try {
      var url = Uri.parse("$baseUrl/products?token=$token");
      var response = await httpClient.get(url);

      if(response.statusCode == 200){
        List p = jsonDecode(response.body);
        List<Product> listProduct = p.map((e) => Product.fromJson(e)).toList();
        return listProduct;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Product?> getProduct(String id) async {
    try{
      var url = Uri.parse("$baseUrl/products/$id?token=$token");
      var response = await httpClient.get(url);

      if(response.statusCode == 200){
        Map<String, dynamic> p = jsonDecode(response.body);
        return Product.fromJson(p);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

}