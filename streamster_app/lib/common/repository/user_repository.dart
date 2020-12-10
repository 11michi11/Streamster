import 'dart:convert';
import 'package:streamster_app/common/model/group_role.dart';
import 'package:streamster_app/preferences/model/preferences.dart';

import '../common.dart';

class UserRepository {
  RestClient restClient = RestClient();

  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();

  User user;
  List<User> users = [];

  Future<User> getUserDetails() async {
    if (user == null) {
      var response = await restClient.client.get(RestClient.getUserUrl);

      if (response.statusCode == 200) {

        var body = json.decode(response.body);

        user = mapUserFromBody(body);
      } else {
        // TODO handle error
        print('getUserDetails: ${response.statusCode}');
        return null;
      }
    }
    return user;
  }

  Future reloadUserDetails() async {
    this.user = null;
    getUserDetails();
  }

  Future<User> getUserDetailsById(String id) async {
    var response = await restClient.client.get('${RestClient.getUserUrl}/$id');

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return mapUserFromBody(body);
    } else {
      // TODO handle error
      print('getUserDetails: ${response.statusCode}');
      return null;
    }
  }

  Future<List<User>> getAllUsers() async {
    if (users.isEmpty) {
      var response = await restClient.client.get(RestClient.getAllUserUrl);

      users = [];
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        for (var user in body) {
          users.add(mapUserFromBody(user));
        }
      }
    }
    return users;
  }

  User mapUserFromBody(dynamic body) {
    var systemRole = assignSystemRole(body['systemRole']);

    /* TODO - add group roles
      List<GroupRole> groups;
      var groupRoles = body['groupRoles'];

      for(var roles in groupRoles) {
        var groupRole = assignGroupRole(roles['role']);
        groups.add(new GroupRole(roles['groupId'], groupRole));
      }
       */
    var preferencesJson = body['preferences'];
    var preferences;
    if (preferencesJson != null) {
      preferences = new Preferences(
          List<String>.from(preferencesJson['tags']),
          List<String>.from(preferencesJson['studyPrograms']),
          preferencesJson['minLength'],
          preferencesJson['maxLength']
      );
    }

    var user = User(
        body['id'],
        body['firstName'],
        body['lastName'],
        body['email'],
        body['avatar'],
        systemRole,
        [],
        preferences);
    return user;
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

  void clear() {
    user = null;
    users = [];
  }
}
