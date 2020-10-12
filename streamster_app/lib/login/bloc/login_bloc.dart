
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/login/repository/login_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;
  final UserRepository _userRepository;

  LoginBloc({@required LoginRepository loginRepository, @required UserRepository userRepository})
      : assert(loginRepository != null),
        _loginRepository = loginRepository,
        _userRepository = userRepository,
        super(const LoginState.unknown());


  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AuthenticateUser) {
      yield LoginState.inProgress();

      var response = await _loginRepository.login(
          username: event.username,
          password: event.password,
        );

       if(response == LoginStatus.authenticated) {
         var user = await _userRepository.getUserDetails();
         yield LoginState.authenticated(user);
       } else {
         yield LoginState.unauthenticated();
       }
    }
  }


}
