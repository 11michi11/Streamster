import 'package:streamster_app/common/common.dart';
import 'dart:convert' as convert;

import '../preferences.dart';

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

  Future<PreferencesStatus> savePreferences(
      Preferences preferences, String id) async {
    var response = await client.client.post(
        RestClient.userUrl.toString() + "/" + id + "/preferences",
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode(preferences.toJson()));
    if (response.statusCode == 200) {
      return PreferencesStatus.success;
    } else {
      return PreferencesStatus.error;
    }
  }
}
