import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/common.dart';

import '../bloc/login_bloc.dart';
import 'login_form.dart';
import '../repository/login_repository.dart';

class LoginPage extends StatelessWidget {
  final LoginRepository loginRepository;
  final UserRepository userRepository;

  LoginPage({Key key, @required this.loginRepository, @required this.userRepository})
      : assert(loginRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              loginRepository: loginRepository,
              userRepository: userRepository);
        },
        child: Center(
          child: LoginForm(),
        ),
      ),
    );
  }
}
