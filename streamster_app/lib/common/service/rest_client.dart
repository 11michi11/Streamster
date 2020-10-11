import 'package:http/http.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:streamster_app/login/login.dart';

class RestClient {
  final clientId = "my-trusted-client";
  final clientSecret = "secret";
  static final baseUrl = "http://localhost:8080";
//  static final baseUrl = 'https://apigateway-ayoqp7z2fq-lz.a.run.app';
  static final authUrl = Uri.parse("$baseUrl/user-service/oauth/token");
  static final registerUrl = Uri.parse("$baseUrl/user-service/user/register");
  Client client;

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
