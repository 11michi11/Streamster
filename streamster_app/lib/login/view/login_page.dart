import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import 'login_form.dart';
import '../repository/login_repository.dart';

class LoginPage extends StatelessWidget {
  final LoginRepository loginRepository;

  LoginPage({Key key, @required this.loginRepository})
      : assert(loginRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              loginRepository: loginRepository);
        },
        child: Center(
          child: LoginFormForWeb(),
        ),
      ),
    );
  }
}
