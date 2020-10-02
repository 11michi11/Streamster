import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:streamster_app/common/app_config.dart';

import 'package:streamster_app/main.dart';

class RestClient {
  final clientId = "my-trusted-client";
  final clientSecret = "secret";
  static final baseUrl = getIt.get<AppConfig>().apiUrl;
  static final authUrl = Uri.parse("$baseUrl/user-service/oauth/token");
  static final registerUrl = Uri.parse("$baseUrl/user-service/user/register");
  var client;

  static final RestClient _instance = RestClient._internal();

  factory RestClient() {
    return _instance;
  }

  RestClient._internal();

  Future<void> login(String username, String password) async {
    client = await oauth2.resourceOwnerPasswordGrant(
        authUrl, username, password,
        identifier: clientId, secret: clientSecret);
  }
}