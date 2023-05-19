class User {
  late int? Id;
  late String? Username;
  late String? Name;
  late String? Password;
  late String? Email;
  late bool? IsVerified;

  User(
      {this.Id,
      this.Email,
      this.Name,
      this.Password,
      this.Username,
      this.IsVerified});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        Id: json['id'],
        Username: json['username'],
        Name: json['name'],
        Email: json['email'],
        Password: json['password'],
        IsVerified: json['isVerified']);
  }
}
