import 'package:equatable/equatable.dart';

abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent();
}

class UpdatePreferences extends PreferencesEvent {
  const UpdatePreferences();

  @override
  List<Object> get props => [];
}
