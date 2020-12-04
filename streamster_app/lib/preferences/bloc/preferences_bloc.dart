import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamster_app/common/repository/user_repository.dart';
import 'package:streamster_app/preferences/model/preferences.dart';
import 'package:streamster_app/preferences/repository/preferences_repository.dart';

import 'preferences_event.dart';
import 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final PreferencesRepository _preferencesRepository;
  final UserRepository _userRepository;

  PreferencesBloc(
      {@required PreferencesRepository preferencesRepository,
      @required UserRepository userRepository})
      : assert(preferencesRepository != null),
        _preferencesRepository = preferencesRepository,
        _userRepository = userRepository,
        super(const PreferencesState.init());

  @override
  Stream<PreferencesState> mapEventToState(PreferencesEvent event) async* {
    if (event is SavePreferences) {
      yield PreferencesState.loading();

      var preferences = new Preferences(
          event.tags, event.studyPrograms, event.minLength, event.maxLength);

      var currentUser = _userRepository.user;

      var response = await _preferencesRepository.savePreferences(
          preferences, currentUser.id);
      if (response == PreferencesStatus.success) {
        yield PreferencesState.success();
        _userRepository.reloadUserDetails();
      } else {
        yield PreferencesState.error("error");
      }
    }
  }
}
