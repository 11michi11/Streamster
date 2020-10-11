
import 'package:equatable/equatable.dart';
import 'package:streamster_app/common/model/user.dart';
import 'package:streamster_app/login/repository/login_repository.dart';

class LoginState extends Equatable {

  final LoginStatus status;
  final User user;

  const LoginState._({
    this.status = LoginStatus.unknown,
    this.user
  });

  const LoginState.unknown() : this._();

  const LoginState.inProgress() : this._(status: LoginStatus.inProgress);

  const LoginState.authenticated(User userDetails) : this._(status: LoginStatus.authenticated, user: userDetails);

  const LoginState.unauthenticated() : this._(status: LoginStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];

}
