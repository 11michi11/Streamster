
import '../common.dart';

class UserRepository {
  RestClient client;

  UserRepository() {
    this.client = RestClient();
  }

  Future<User> getUserDetails() async {
    var response = client.getUserDetails();
    return response;
  }

  Future<List<User>> getAllUsers() async {
    var response = client.getAllUsers();
    return response;
  }

}
