import 'package:http/http.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:streamster_app/common/app_config.dart';

import 'package:streamster_app/main.dart';

import 'package:streamster_app/login/login.dart';

class RestClient {
  final clientId = "my-trusted-client";
  final clientSecret = "secret";
  static final baseUrl = getIt.get<AppConfig>().apiUrl;
  static final authUrl = Uri.parse("$baseUrl/user-service/oauth/token");
  static final registerUrl = Uri.parse("$baseUrl/user-service/user/register");
  Client client;

  static final RestClient _instance = RestClient._internal();

  factory RestClient() {
    return _instance;
  }

  RestClient._internal();
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