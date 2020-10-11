import 'package:streamster_app/common/common.dart';
import 'package:meta/meta.dart';

enum LoginStatus { unknown, authenticated, unauthenticated, inProgress }

class LoginRepository {
  RestClient client;

  LoginRepository() {
    this.client = RestClient();
  }

  Future<LoginStatus> login({
    @required String username,
    @required String password,
  }) async {

    var response = await this.client.login(username, password);
    return response;
  }



}