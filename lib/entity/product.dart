import 'package:payetonkawa/entity/detail_product.dart';

class Product{
  String? id;
  String? name;
  int? stock;
  DetailProduct? details;

  Product({this.id, this.name, this.stock, this.details});

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"].toString(),
      name: json["name"],
      stock: (json["stock"] is String ? int.parse(json["stock"]) : json["stock"]),
      details: DetailProduct.fromJson(json["details"])
    );
  }
}