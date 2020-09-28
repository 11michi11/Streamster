
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/register/repository/register_repository.dart';

import '../bloc/register_bloc.dart';
import 'register_form.dart';

class RegisterPage extends StatelessWidget {
  final RegisterRepository registerRepository;

  RegisterPage({Key key, @required this.registerRepository})
      : assert(registerRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return RegisterBloc(registerRepository: registerRepository);
        },
        child: Center(
          child:
            RegisterFormForWeb(),
        ),
      ),
    );
  }
}
