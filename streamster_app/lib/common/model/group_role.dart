
enum GroupRoles { group_owner, teacher, instructor, student }

extension GroupRoleAsString on GroupRoles {

  String get name {
    switch(this) {
      case GroupRoles.group_owner:
        return 'groupOwner';
      case GroupRoles.teacher:
        return 'teacher';
      case GroupRoles.instructor:
        return 'instructor';
      case GroupRoles.student:
        return 'student';
      default:
        return null;
    }
  }
}

class GroupRole {

  String group;
  GroupRoles role;

  GroupRole(this.group, this.role);
}