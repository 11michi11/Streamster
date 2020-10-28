class LoginValidator {
  static bool isUsernameNotValid(String username) {
    return username.isEmpty;
  }

  static bool isPasswordNotValid(String password) {
    return password.isEmpty;
  }
}
