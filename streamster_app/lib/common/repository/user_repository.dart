import 'package:film_master_app/common/service/dto/user_info.dart';
import 'package:meta/meta.dart';

import '../common.dart';

class UserRepository {
  RestClient client;

  UserRepository() {
    this.client = RestClient();
  }

  Future<String> login({
    @required String username,
    @required String password,
  }) async {
    await this.client.login(username, password);
    return "Success";
  }

  Future<void> register({String name, String email, String password}) async {
    var user = UserInfo(name, email, password);
    print(user.toJson().toString());
    await this.client.register(user);
  }
}
