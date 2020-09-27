
import 'package:equatable/equatable.dart';
import 'package:streamster_app/login/repository/login_repository.dart';

class LoginState extends Equatable {

  final LoginStatus status;

  const LoginState._({
    this.status = LoginStatus.unknown,
  });

  const LoginState.unknown() : this._();

  const LoginState.inProgress() : this._(status: LoginStatus.inProgress);

  const LoginState.authenticated() : this._(status: LoginStatus.authenticated);

  const LoginState.unauthenticated() : this._(status: LoginStatus.unauthenticated);

  @override
  List<Object> get props => [status];

}
