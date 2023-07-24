import 'dart:convert';

import 'package:http/http.dart';
import 'package:payetonkawa/entity/product.dart';
import 'package:http/http.dart' as http;

class ProductModel {
  Client httpClient = http.Client();

  Future<List<Product>?> getAllProduct() async {
    try {
      var url = Uri.parse("https://615f5fb4f7254d0017068109.mockapi.io/api/v1/products");
      var response = await http.get(url);

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

}