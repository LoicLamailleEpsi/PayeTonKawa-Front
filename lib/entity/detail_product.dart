class DetailProduct {
  String? price;
  String? description;
  String? color;

  DetailProduct({this.price, this.description, this.color});
  
  factory DetailProduct.fromJson(Map<String, dynamic> json){
    return DetailProduct(
      price: (json["price"] is String ? json["price"] : json["price"].toString()),
      description: json["description"],
      color: json["color"]
    );
  }
}