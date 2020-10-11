
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamster_app/login/repository/login_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc({@required LoginRepository loginRepository})
      : assert(loginRepository != null),
        _loginRepository = loginRepository,
        super(const LoginState.unknown());


  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AuthenticateUser) {
      yield LoginState.inProgress();

       var response =  await _loginRepository.login(
          username: event.username,
          password: event.password,
       );

       if(response == LoginStatus.authenticated) {
         yield LoginState.authenticated();
       } else {
         LoginState.unauthenticated();
       }
    }
  }


}
