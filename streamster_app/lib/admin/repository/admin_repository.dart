import 'package:meta/meta.dart';
import 'package:streamster_app/common/common.dart';

enum AdminStatus { init, success, error, loading, updateSuccessful }

class AdminRepository {
  RestClient restClient;

  AdminRepository() {
    this.restClient = RestClient();
  }

  Future<AdminStatus> updateSystemRole(
      {@required String userID, @required SystemRole systemRole}) async {
    var role = systemRole.name.toUpperCase();
    var updateUserRoleUrl = Uri.parse(
        '${RestClient.baseUrl}/user-service/users/$userID/updateSystemRole?role=$role');
    var response = await restClient.client.put(updateUserRoleUrl);

    if (response.statusCode == 200) {
      return AdminStatus.updateSuccessful;
    } else {
      return AdminStatus.error;
    }
  }
}
