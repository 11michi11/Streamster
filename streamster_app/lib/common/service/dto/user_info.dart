class UserInfo {
  String firstName;
  String lastName;
  String email;
  String password;
  String avatar;

  UserInfo(this.firstName, this.lastName, this.email, this.password, this.avatar);

  Map toJson() =>
      {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'avatar': avatar
      };
}
