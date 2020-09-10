import 'package:film_master_app/authentication/authentication.dart';
import 'package:film_master_app/common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc({@required this.userRepository})
      : assert(userRepository != null);

  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterInProgress();
      print(event.toString());
      try {
        await userRepository.register(
          name: event.name,
          email: event.email,
          password: event.password,
        );

        yield RegisterSuccess();
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
    }
  }
}
