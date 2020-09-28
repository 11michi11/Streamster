
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamster_app/register/repository/register_repository.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository _registerRepository;

  RegisterBloc({@required RegisterRepository registerRepository})
      : assert(registerRepository != null),
        _registerRepository = registerRepository,
        super(const RegisterState.init());


  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {

    if (event is RegisterButtonPressed) {
      yield RegisterState.inProgress();

       var response = await _registerRepository.register(
          firstName: event.firstName,
          email: event.email,
          password: event.password,
       );
       if(response == RegistrationStatus.success) {
         yield RegisterState.success();
      } else {
         yield RegisterState.error("error");
       }
    }
  }
}
