class User {
  int Id = null!;

  String? Username;

  String Name = null!;

  String Password = null!;

  String Email = null!;

  bool IsVerified = null!;

  User(this.Id, this.Email, this.Name, this.Password, this.Username,
      this.IsVerified);
}
