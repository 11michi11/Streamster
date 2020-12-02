import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/common/service/dto/user_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

enum PreferencesStatus {
  init,
  loading,
  success,
  error,
}

class PreferencesRepository {
  RestClient client;

  PreferencesRepository() {
    this.client = RestClient();
  }

  updatePreferences() {

  }
}
