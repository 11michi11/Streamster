import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/common/service/dto/user_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

enum RegistrationStatus {
  init,
  loading,
  success,
  error,
}

class RegisterRepository {
  String tag = 'RegisterRepository | ';
  RestClient client;

  RegisterRepository() {
    this.client = RestClient();
  }

  Future<RegistrationStatus> register(
      {String firstName,
      String lastName,
      String email,
      String password,
      String avatar}) async {

    var user = UserInfo(firstName, lastName, email, password, avatar);

    var response = await http.post(RestClient.registerUrl,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode(user.toJson()));

    if (response.statusCode == 200) {
      return RegistrationStatus.success;
    } else {
      return RegistrationStatus.error;
    }
  }
}
