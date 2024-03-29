class UserModel {
  int id;
  String? username;
  String name;
  String email;
  bool select;

  UserModel({
    required this.id,
    this.username,
    required this.name,
    required this.email,
    this.select = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
    );
  }
}
