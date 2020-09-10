import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'dto/user_info.dart';

class RestClient {
  final clientId = "my-trusted-client";
  final clientSecret = "secret";
  static final baseUrl = "http://localhost:8080";
  final authUrl = Uri.parse("$baseUrl/user-service/oauth/token");
  final registerUrl = Uri.parse("$baseUrl/user-service/user/register");
  var client;

  Future<void> login(String username, String password) async {
    this.client = await oauth2.resourceOwnerPasswordGrant(
        authUrl, username, password,
        identifier: clientId, secret: clientSecret);
  }

  Future<void> register(UserInfo userInfo) async {
    var response = await http.post(registerUrl,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode(userInfo));
    print(response.body);
  }
}