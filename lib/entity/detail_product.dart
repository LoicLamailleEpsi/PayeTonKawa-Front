import 'package:json_annotation/json_annotation.dart';

part 'detail_product.g.dart';

@JsonSerializable()
class DetailProduct {
  String? price;
  String? description;
  String? color;

  DetailProduct();
  
  factory DetailProduct.fromJson(Map<String, dynamic> json) => _$DetailProductFromJson(json);
  Map<String, dynamic> toJson() => _$DetailProductToJson(this);
}