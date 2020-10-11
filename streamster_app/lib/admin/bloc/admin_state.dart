
import 'package:equatable/equatable.dart';
import 'package:streamster_app/common/model/user.dart';
import '../admin.dart';

class AdminState extends Equatable {

  final AdminStatus status;
  final List<User> users;
  final String error;

  const AdminState._({
    this.status = AdminStatus.init,
    this.users,
    this.error
  });

  const AdminState.init() : this._();

  const AdminState.loading() : this._(status: AdminStatus.loading);

  const AdminState.updateSuccessful() : this._(status: AdminStatus.updateSuccessful);

  const AdminState.getUsers(List<User> userList) : this._(status: AdminStatus.success, users: userList);

  const AdminState.error(String message) : this._(status: AdminStatus.error, error: message);

  @override
  List<Object> get props => [status, error, users];

}