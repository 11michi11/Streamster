import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class AuthenticateUser extends LoginEvent {
  final String username;
  final String password;

  const AuthenticateUser({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

class GetUserDetails extends LoginEvent {

  @override
  List<Object> get props => [];

}
