
import 'package:equatable/equatable.dart';
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

  const AdminState.inProgress() : this._(status: AdminStatus.inProgress);

  const AdminState.success() : this._(status: AdminStatus.success);

  const AdminState.getUserSuccess(List<User> userList) : this._(status: AdminStatus.success, users : userList);

  const AdminState.error(String message) : this._(status: AdminStatus.error, error: message);

  @override
  List<Object> get props => [status, error, users];

}