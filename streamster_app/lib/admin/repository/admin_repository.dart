import 'package:streamster_app/common/common.dart';
import 'package:http/http.dart' as http;

enum AdminStatus { init, success, error, inProgress }

class AdminRepository {
  RestClient client;

  AdminRepository() {
    this.client = RestClient();
  }

  //TODO - add url and correct body attributes
  Future<AdminStatus> updateSystemRole({String userId, String systemRole}) async {

    var response = await http.post('',
        headers: {'Content-Type': 'application/json'},
        body: {
          'userID' : userId,
          'SystemRole' :systemRole
        });

    if(response.statusCode == 200) {
      return AdminStatus.success;
    } else {
      return AdminStatus.error;
    }
  }



}