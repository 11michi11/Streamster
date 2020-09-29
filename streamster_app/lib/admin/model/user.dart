
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
        return 'no such a role';
    }
  }
}

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String password;
  String avatar;
  SystemRole systemRole;

  User(this.id, this.firstName, this.lastName, this.email, this.password, this.avatar,
      this.systemRole);

  Map<String, dynamic> get map {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'avatar': avatar,
      'systemRole':systemRole
    };
  }

  Map toJson() =>
      {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'avatar': avatar,
        'systemRole':systemRole.toString()
      };

}

