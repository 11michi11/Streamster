
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:oauth2/oauth2.dart';
import 'package:streamster_app/common/app_config.dart';
import 'package:streamster_app/main.dart';
import 'package:streamster_app/login/login.dart';

class RestClient {
  final clientId = "my-trusted-client";
  final clientSecret = "secret";
  static final baseUrl = getIt.get<AppConfig>().apiUrl;
  static final authUrl = Uri.parse("$baseUrl/user-service/oauth/token");
  static final registerUrl = Uri.parse("$baseUrl/user-service/user/register");
  static final getUserUrl = Uri.parse("$baseUrl/user-service/users/userDetails");
  static final getAllUserUrl = Uri.parse("$baseUrl/user-service/users");

  Client client;

  static final RestClient _instance = RestClient._internal();

  factory RestClient() {
    return _instance;
  }

  RestClient._internal();

  //TODO - when error unauthenticated in NOT returned, find the way how to handle error state
  Future<LoginStatus> login(String username, String password) async {
    client = await oauth2
        .resourceOwnerPasswordGrant(authUrl, username, password,
        identifier: clientId, secret: clientSecret)
        .catchError((error) {
      print('login error: $error ');
      return LoginStatus.unauthenticated;
    });
    return LoginStatus.authenticated;
  }


}
