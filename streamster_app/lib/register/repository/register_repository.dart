import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/common/service/dto/user_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

enum RegistrationStatus {
  init,
  loading,
  success,
  emailNotUnique,
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

    print("Sending register request");
    print(RestClient.registerUrl.toString());
    var response = await http.post(RestClient.registerUrl,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode(user.toJson()));
    print("Received register response");
    if (response.statusCode == 201) {
      return RegistrationStatus.success;
    } else if (response.statusCode == 400 &&
        response.body == "Given email is already used in the system") {
      print("Inserted email is already used in the system.");
      return RegistrationStatus.emailNotUnique;
    } else {
      return RegistrationStatus.error;
    }
  }
}
