import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/common.dart';

import 'logout_event.dart';
import 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final UserRepository _userRepository = UserRepository();
  final RestClient _restClient = RestClient();

  LogoutBloc() : super(const LogoutState.unknown());

  @override
  Stream<LogoutState> mapEventToState(LogoutEvent event) async* {
    if (event is LogoutUser) {
      _userRepository.clear();
      _restClient.logout();

      yield LogoutState.success();
    }
  }
}
