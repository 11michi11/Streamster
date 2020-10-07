import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:oauth2/oauth2.dart';
import 'package:streamster_app/common/app_config.dart';
import 'package:streamster_app/main.dart';

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

  Future<void> login(String username, String password) async {
    client = await oauth2.resourceOwnerPasswordGrant(
        authUrl, username, password,
        identifier: clientId, secret: clientSecret);
  }

  Future<void> upload(List<int> bytes, String filename) async {
    print("sending");
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://localhost:8080/video-service/upload"));
    request.files
        .add(http.MultipartFile.fromBytes('video', bytes, filename: filename));
    var result = await client.send(request);
    print("result: $result");
  }
}
