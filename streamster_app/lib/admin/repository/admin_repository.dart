import 'package:meta/meta.dart';
import 'package:streamster_app/common/common.dart';

enum AdminStatus { init, success, error, loading, updateSuccessful }

class AdminRepository {
  RestClient client;

  AdminRepository() {
    this.client = RestClient();
  }

  Future<AdminStatus> updateSystemRole({@required String userId, @required SystemRole systemRole}) async {
    var response = client.updateSystemRole(userID: userId, systemRole: systemRole);
    return response;
  }

}