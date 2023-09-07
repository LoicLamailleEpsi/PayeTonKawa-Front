import 'dart:convert';

import 'package:http/testing.dart';
import 'package:payetonkawa/entity/product.dart';
import 'package:payetonkawa/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ProductModel extends Model {
  late String? _token;
  late Map<String, String> _headersData;
  
  ProductModel({MockClient? mockClient}) : super(mockClient: mockClient){
    _token = getIt<SharedPreferences>().getString(idUserPreferenceKey);
    _headersData = {
      "token": _token ?? "",
    };
  }

  Future<List<Product>?> getAllProducts() async {
    try {
      var url = Uri.parse("$baseUrl/products");
      var response = await httpClient.get(url, headers: _headersData);

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
      var url = Uri.parse("$baseUrl/products/$id");
      var response = await httpClient.get(url, headers: _headersData);

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