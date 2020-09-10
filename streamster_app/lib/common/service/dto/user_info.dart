class UserInfo {
  String name;
  String email;
  String password;

  UserInfo(this.name, this.email, this.password);

  Map toJson() =>
      {
        'name': name,
        'email': email,
        'password': password,
      };
}
