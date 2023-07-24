import 'dart:convert';

import 'package:http/http.dart';
import 'package:payetonkawa/entity/product.dart';
import 'package:http/http.dart' as http;
import 'package:payetonkawa/model/product.dart';

class ProductModel extends Model {
  Client httpClient = http.Client();

  Future<List<Product>?> getAllProducts() async {
    try {
      var url = Uri.parse("$baseUrl/products");
      var response = await httpClient.get(url);

      if(response.statusCode == 200){
        List p = jsonDecode(response.body);
        List<Product> _listProduct = p.map((e) => Product.fromJson(e)).toList();
        return _listProduct;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Product?> getProduct(String id) async {
    try{
      var url = Uri.parse("$baseUrl/products/$id");
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