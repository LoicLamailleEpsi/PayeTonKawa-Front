class Customer {
  String? id;
  String? email;
  String? username;

  Customer({this.id, this.email, this.username});

  factory Customer.fromJson(Map<String, dynamic> json){
    return Customer(
      id: json["id"],
      email: json["email"],
      username: json["username"]
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'username': username
  };
}