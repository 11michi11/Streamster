import 'package:equatable/equatable.dart';
import 'package:streamster_app/preferences/repository/preferences_repository.dart';

class PreferencesState extends Equatable {
  final PreferencesStatus status;
  final String error;

  const PreferencesState._({this.status = PreferencesStatus.init, this.error});

  const PreferencesState.init() : this._();

  const PreferencesState.loading() : this._(status: PreferencesStatus.loading);

  const PreferencesState.success() : this._(status: PreferencesStatus.success);

  const PreferencesState.error(String message)
      : this._(status: PreferencesStatus.error, error: message);

  @override
  List<Object> get props => [status, error];

  @override
  String toString() => 'PreferencesFailure { error: $error }';
}
