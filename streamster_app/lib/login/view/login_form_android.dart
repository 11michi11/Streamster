import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/login/bloc/login_validator.dart';
import 'package:streamster_app/login/view/login_common_widgets.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../repository/login_repository.dart';

class LoginFormAndroid extends StatefulWidget {
  final LoginState state;

  LoginFormAndroid(this.state);

  @override
  State<LoginFormAndroid> createState() => _LoginFormAndroidState();
}

class _LoginFormAndroidState extends State<LoginFormAndroid> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
            child: Opacity(
                opacity: 0.7,
                child: Image(image: AssetImage("images/book2.jpg")))),
        LoginCommonWidgets.header(),
        Container(
          margin: EdgeInsets.only(bottom: 35.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginCommonWidgets.customTextField("Email :"),
                  Container(
                    width: 170.0,
                    child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                            contentPadding: EdgeInsets.only(top: 10.0),
                            hintText: 'Enter your email')),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginCommonWidgets.customTextField("Password :"),
                  Container(
                    width: 170.0,
                    child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
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
        Column(children: [
          loginButton(widget.state),
          SizedBox(height: 20), //margin
          LoginCommonWidgets.createAccountButton(context),
          SizedBox(height: 50), //margin
        ]),
      ],
    );
  }

  Widget loginButton(LoginState state) {
    return ButtonTheme(
      minWidth: 200,
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
