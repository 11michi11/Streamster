import 'dart:convert';
import 'package:flutter/services.dart';

class AppConfig {
  final String apiUrl;

  AppConfig({this.apiUrl});

  static Future<AppConfig> forEnvironment(String env) async {
    // set default to dev if nothing was passed
    env = env ?? 'dev';
    final contents = await rootBundle.loadString(
      'assets/config/$env.json',
    );
    final json = jsonDecode(contents);
    return AppConfig(apiUrl: json['apiUrl']);
  }
}
