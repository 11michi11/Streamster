import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:streamster_app/admin/admin.dart';
import 'package:streamster_app/common/app_config.dart';
import 'package:streamster_app/common/model/group_role.dart';
import 'package:streamster_app/common/model/user.dart';

import 'package:streamster_app/main.dart';

import 'package:streamster_app/login/login.dart';

class RestClient {
  final clientId = "my-trusted-client";
  final clientSecret = "secret";
  static final baseUrl = getIt.get<AppConfig>().apiUrl;
  static final authUrl = Uri.parse("$baseUrl/user-service/oauth/token");
  static final registerUrl = Uri.parse("$baseUrl/user-service/user/register");
  static final getUserUrl = Uri.parse("$baseUrl/user-service/users/userDetails");
  static final getAllUserUrl = Uri.parse("$baseUrl/user-service/users");

  Client client;

  static final RestClient _instance = RestClient._internal();

  factory RestClient() {
    return _instance;
  }

  RestClient._internal();

  Future<LoginStatus> login(String username, String password) async {
    client = await oauth2
        .resourceOwnerPasswordGrant(authUrl, username, password,
            identifier: clientId, secret: clientSecret)
        .catchError((error) {
      print('login error: $error ');
      return LoginStatus.unauthenticated;
    });
    return LoginStatus.authenticated;
  }

  Future<User> getUserDetails() async {

    var response = await client.get(RestClient.getUserUrl);

    if(response.statusCode == 200) {

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
      var user = User(body['id'], body['firstName'], body['lastName'], body['email'], body['avatar'], systemRole, null);
      print(user.toString());
      return user;
    } else {
      print('getUserDetails: ${response.statusCode}');
      return null;
    }
  }

  Future<List<User>> getAllUsers() async {

    var response = await client.get(RestClient.getAllUserUrl);

    List<User> users = new List<User>();
    List<GroupRole> groups = new List<GroupRole>();

    if(response.statusCode == 200){
      var body = json.decode(response.body);

      for(var user in body) {
        var systemRole = assignSystemRole(user['systemRole']);

        /* TODO - add group roles
        var groupRoles = user['groupRoles'];

        for(var roles in groupRoles) {
          var groupRole = assignGroupRole(roles['role']);
          groups.add(new GroupRole(roles['groupId'], groupRole));
        }
        */
        users.add(new User(user['id'], user['firstName'], user['lastName'], user['email'], user['avatar'], systemRole, groups));
      }
    }

    return users;
  }

  Future<AdminStatus> updateSystemRole({@required String userID, @required SystemRole systemRole}) async {

    var role = systemRole.name.toUpperCase();
    var updateUserRoleUrl = Uri.parse('$baseUrl/user-service/users/$userID/updateSystemRole?role=$role');
    var response = await client.put(updateUserRoleUrl);

    if(response.statusCode == 200){
      return AdminStatus.updateSuccessful;
    } else {
      return AdminStatus.error;
    }
  }

  SystemRole assignSystemRole(String role) {

    switch(role) {
      case('ADMIN'):
        return SystemRole.admin;
        break;
      case('STUDENT'):
        return SystemRole.student;
        break;
      case('TEACHER'):
        return SystemRole.teacher;
      default:
        return null;
    }
  }

  GroupRoles assignGroupRole(String role) {
    switch(role) {
      case('GROUP_OWNER'):
        return GroupRoles.group_owner;
        break;
      case('TEACHER'):
        return GroupRoles.teacher;
        break;
      case('INSTRUCTOR'):
        return GroupRoles.instructor;
      case('STUDENT'):
        return GroupRoles.student;
      default:
        return null;
    }
  }



  Future<void> upload(List<int> bytes, String filename) async {
    print("sending");
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://localhost:8080/video-service/upload"));
    request.files
        .add(http.MultipartFile.fromBytes('video', bytes, filename: filename));
    var result = await client.send(request);
    print("result: $result");
  }
}
