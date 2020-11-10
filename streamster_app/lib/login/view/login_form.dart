import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/model/user.dart';
import 'package:streamster_app/login/view/login_form_android.dart';
import 'package:streamster_app/login/view/login_form_web.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import '../repository/login_repository.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        handleState(state);
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 1000) {
            return LoginFormWeb(state);
          } else {
            return LoginFormAndroid(state);
          }
        });
      }),
    );
  }

  void handleState(LoginState state) {
    if (state.status == LoginStatus.authenticated) {
      if (state.user != null) {
        if (state.user.systemRole == SystemRole.admin) {
          Navigator.of(context).pushNamed('/admin');
        } else {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
    } else if (state.status == LoginStatus.unauthenticated) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Bad credentials'),
        backgroundColor: Colors.red,
      ));
      //Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
