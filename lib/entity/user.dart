class User {
  String? id;
  String? username;
  String? email;
  String? token;

  User({this.id, this.username, this.email, this.token});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      email: json["username"],
      username: json["email"],
      token: json["token"]
    );
  }
}