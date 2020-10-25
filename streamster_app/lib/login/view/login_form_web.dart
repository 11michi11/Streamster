import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/login/bloc/login_validator.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../repository/login_repository.dart';
import 'login_common_widgets.dart';

class LoginFormWeb extends StatefulWidget {
  final LoginState state;

  LoginFormWeb(this.state);

  @override
  State<LoginFormWeb> createState() => _LoginFormWebState();
}

class _LoginFormWebState extends State<LoginFormWeb> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Opacity(
                    opacity: 0.7,
                    child: Image(image: AssetImage("images/book1.jpg")))),
            LoginCommonWidgets.header(),
            Container(
              margin: EdgeInsets.only(bottom: 35.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 150.0,
                          margin: EdgeInsets.only(right: 20.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text("Email: ",
                                style: TextStyle(
                                    fontFamily: 'BalooTammudu',
                                    color: Colors.brown,
                                    fontSize: 20.0)),
                          )),
                      Container(
                        width: 235,
                        child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                                hintStyle:
                                    TextStyle(fontFamily: 'BalooTammudu'),
                                contentPadding: EdgeInsets.only(top: 10.0),
                                hintText: 'Enter your email')),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 150.0,
                          margin: EdgeInsets.only(right: 20.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text("Password: ",
                                style: TextStyle(
                                    fontFamily: 'BalooTammudu',
                                    color: Colors.brown,
                                    fontSize: 20.0)),
                          )),
                      Container(
                        width: 235,
                        child: TextField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                                hintStyle:
                                    TextStyle(fontFamily: 'BalooTammudu'),
                                contentPadding: EdgeInsets.only(top: 10.0),
                                hintText: 'Enter your password')),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
                child: widget.state.status == LoginStatus.inProgress
                    ? CircularProgressIndicator()
                    : null),
            loginButton(widget.state),
            LoginCommonWidgets.createAccountButton(context)
          ],
        ),
      ),
    );
  }

  Widget loginButton(LoginState state) {
    return ButtonTheme(
      minWidth: 180,
      height: 60,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.brown),
            borderRadius: BorderRadius.circular(18.0)),
        color: Colors.white,
        onPressed: () {
          if (state.status != LoginStatus.inProgress) {
            onLoginButtonPressed();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 9.0),
          child: Text('Login',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'BalooTammudu',
                  color: Colors.brown)),
        ),
      ),
    );
  }

  onLoginButtonPressed() {
    if (LoginValidator.isUsernameNotValid(_usernameController.text)) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Email is empty'),
        backgroundColor: Colors.red,
      ));
    } else if (LoginValidator.isPasswordNotValid(_passwordController.text)) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Password is empty'),
        backgroundColor: Colors.red,
      ));
    } else {
      BlocProvider.of<LoginBloc>(context).add(AuthenticateUser(
          username: _usernameController.text,
          password: _passwordController.text));
    }
  }
}
