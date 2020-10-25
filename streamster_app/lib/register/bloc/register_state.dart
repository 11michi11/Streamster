import 'package:equatable/equatable.dart';
import 'package:streamster_app/register/repository/register_repository.dart';

class RegisterState extends Equatable {

  final RegistrationStatus status;
  final String error;

  const RegisterState._({
    this.status = RegistrationStatus.init,
    this.error
  });

  const RegisterState.init() : this._();

  const RegisterState.loading() : this._(status: RegistrationStatus.loading);

  const RegisterState.success() : this._(status: RegistrationStatus.success);

  const RegisterState.error(String message) : this._(status: RegistrationStatus.error, error: message);

  @override
  List<Object> get props => [status, error];

  @override
  String toString() => 'RegisterFailure { error: $error }';
}
