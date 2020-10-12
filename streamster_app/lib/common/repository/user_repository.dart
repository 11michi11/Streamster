import 'dart:convert';
import 'package:streamster_app/common/model/group_role.dart';

import '../common.dart';

class UserRepository {
  RestClient restClient;

  UserRepository() {
    this.restClient = RestClient();
  }

  Future<User> getUserDetails() async {
    var response = await restClient.client.get(RestClient.getUserUrl);

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var systemRole = assignSystemRole(body['systemRole']);

      /* TODO - add group roles
      List<GroupRole> groups;
      var groupRoles = body['groupRoles'];

      for(var roles in groupRoles) {
        var groupRole = assignGroupRole(roles['role']);
        groups.add(new GroupRole(roles['groupId'], groupRole));
      }
       */
      var user = User(body['id'], body['firstName'], body['lastName'],
          body['email'], body['avatar'], systemRole, null);
      print(user.toString());
      return user;
    } else {
      print('getUserDetails: ${response.statusCode}');
      return null;
    }
  }

  Future<List<User>> getAllUsers() async {
    var response = await restClient.client.get(RestClient.getAllUserUrl);

    List<User> users = new List<User>();
    List<GroupRole> groups = new List<GroupRole>();

    if (response.statusCode == 200) {
      var body = json.decode(response.body);

      for (var user in body) {
        var systemRole = assignSystemRole(user['systemRole']);

        /* TODO - add group roles
        var groupRoles = user['groupRoles'];

        for(var roles in groupRoles) {
          var groupRole = assignGroupRole(roles['role']);
          groups.add(new GroupRole(roles['groupId'], groupRole));
        }
        */
        users.add(new User(user['id'], user['firstName'], user['lastName'],
            user['email'], user['avatar'], systemRole, groups));
      }
    }

    return users;
  }

  SystemRole assignSystemRole(String role) {
    switch (role) {
      case ('ADMIN'):
        return SystemRole.admin;
        break;
      case ('STUDENT'):
        return SystemRole.student;
        break;
      case ('TEACHER'):
        return SystemRole.teacher;
      default:
        return null;
    }
  }

  GroupRoles assignGroupRole(String role) {
    switch (role) {
      case ('GROUP_OWNER'):
        return GroupRoles.group_owner;
        break;
      case ('TEACHER'):
        return GroupRoles.teacher;
        break;
      case ('INSTRUCTOR'):
        return GroupRoles.instructor;
      case ('STUDENT'):
        return GroupRoles.student;
      default:
        return null;
    }
  }
}
