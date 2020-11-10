
import 'package:streamster_app/common/model/group_role.dart';

enum SystemRole { admin, teacher, student }

extension SystemRoleAsString on SystemRole {

  String get name {
    switch(this) {
      case SystemRole.admin:
        return 'admin';
      case SystemRole.teacher:
        return 'teacher';
      case SystemRole.student:
        return 'student';
      default:
        return null;
    }
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final SystemRole systemRole;
  final List<GroupRole> groupRoles;

  User(this.id, this.firstName, this.lastName, this.email, this.avatar,
      this.systemRole, this.groupRoles);

  Map<String, dynamic> get map {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'systemRole':systemRole,
      'groupRoles':groupRoles
    };
  }

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, email: $email, avatar: $avatar, systemRole: ${systemRole.name}, groupRoles: $groupRoles}';
  }
}

