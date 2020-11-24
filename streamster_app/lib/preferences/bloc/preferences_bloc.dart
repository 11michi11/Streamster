import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamster_app/preferences/repository/preferences_repository.dart';

import 'preferences_event.dart';
import 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final PreferencesRepository _preferencesRepository;

  PreferencesBloc({@required PreferencesRepository preferencesRepository})
      : assert(preferencesRepository != null),
        _preferencesRepository = preferencesRepository,
        super(const PreferencesState.init());

  @override
  Stream<PreferencesState> mapEventToState(PreferencesEvent event) async* {
    if (event is UpdatePreferences) {
      yield PreferencesState.loading();

      var response = await _preferencesRepository.updatePreferences();
      if (response == PreferencesStatus.success) {
        yield PreferencesState.success();
      } else {
        yield PreferencesState.error("error");
      }
    }
  }
}
