import 'package:film_master_app/authentication/authentication_bloc.dart';
import 'package:film_master_app/common/common.dart';
import 'package:film_master_app/home/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/register_bloc.dart';
import 'register_form.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository userRepository;

  RegisterPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return RegisterBloc(userRepository: userRepository);
        },
        child: Column(
          children: [
            Header(),
            RegisterForm(),
          ],
        ),
      ),
    );
  }
}
