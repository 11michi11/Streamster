import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/register/register.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_state.dart';
import '../repository/register_repository.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        handleState(state);
      },
      child:
      BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 1100) {
            return RegisterWeb(state);
          } else {
            return RegisterAndroid(state);
          }
        });
      }),
    );
  }

  void handleState(RegisterState state) {
    if (state.status == RegistrationStatus.error) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('$state.error'),
        backgroundColor: Colors.red,
      ));
    }
    else if (state.status == RegistrationStatus.emailAlreadyUsed) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('This email is already being used'),
        backgroundColor: Colors.red,
      ));
    }else if (state.status == RegistrationStatus.success) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
        backgroundColor: Colors.green,
      ));
      Navigator.of(context).pushNamed('/login');
    } else if (state.status == RegistrationStatus.loading) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('registering ...'),
        backgroundColor: Colors.blueGrey,
      ));
    }
  }
}
