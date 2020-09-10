import 'package:film_master_app/common/common.dart';
import 'authentication_event.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
//      final bool isLoggedIn = userRepository.isLoggedIn();
//
//      if (isLoggedIn)
      yield AuthenticationSuccess();
//      else
//        yield AuthenticationFailure();
    }

    if (event is AuthenticationLoggedIn) {
      yield AuthenticationInProgress();
      yield AuthenticationSuccess();
    }

    if (event is AuthenticationLoggedOut) {
      yield AuthenticationInProgress();
//      await userRepository.logout();
      yield AuthenticationFailure();
    }
  }
}
