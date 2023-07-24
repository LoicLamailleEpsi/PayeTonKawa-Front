// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailProduct _$DetailProductFromJson(Map<String, dynamic> json) =>
    DetailProduct()
      ..price = json['price'] as String?
      ..description = json['description'] as String?
      ..color = json['color'] as String?;

Map<String, dynamic> _$DetailProductToJson(DetailProduct instance) =>
    <String, dynamic>{
      'price': instance.price,
      'description': instance.description,
      'color': instance.color,
    };
