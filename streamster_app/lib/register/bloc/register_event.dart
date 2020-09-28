import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterButtonPressed extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String image;

  const RegisterButtonPressed({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
    @required this.image
  });

  @override
  List<Object> get props => [firstName, lastName, email, password, image];

  @override
  String toString() {
    return 'RegisterButtonPressed{first name: $firstName, last name: $lastName, email: $email, password: $password}';
  }
}
