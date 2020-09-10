import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('$state.error'),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Form(
          child: Center(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'username',
                        labelStyle: TextStyle(fontSize: 25)),
                    controller: _usernameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'password',
                        labelStyle: TextStyle(fontSize: 25)),
                    controller: _passwordController,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: state is! LoginInProgress
                            ? _onLoginButtonPressed
                            : null,
                        child: Text('Login', style: TextStyle(fontSize: 19)),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.03,
                      ),
                      RaisedButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/register'),
                        child: Text('Register', style: TextStyle(fontSize: 19)),
                      ),
                    ],
                  ),
                  Container(
                    child: state is LoginInProgress
                        ? CircularProgressIndicator()
                        : null,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
