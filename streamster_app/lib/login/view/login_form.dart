import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../repository/login_repository.dart';

class LoginFormForWeb extends StatefulWidget {
  @override
  State<LoginFormForWeb> createState() => _LoginFormForWebState();
}

class _LoginFormForWebState extends State<LoginFormForWeb> {

  String tag = 'LoginForm |';

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(AuthenticateUser(
        username: _usernameController.text,
        password: _passwordController.text));
  }

  /*  --------------------------------------------------------- SHARED WIDGETS ----------------------------------------------------------------------- */

  Widget createAccountButton() {
    return FlatButton(
        onPressed: () => Navigator.of(context).pushNamed('/register'),
        child: Text.rich(
          TextSpan(
            text: 'or create a ',
            style: TextStyle(
                fontSize: 15, fontFamily: 'BalooTammudu', color: Colors.brown),
            children: <TextSpan>[
              TextSpan(
                  text: 'new account',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'BalooTammudu',
                    color: Colors.brown,
                    decoration: TextDecoration.underline,
                  )),
              // can add more TextSpans here...
            ],
          ),
        ));
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

  Widget header() {
    return Text("Login to Streamster",
        style: TextStyle(
            fontFamily: 'BalooTammuduBold',
            color: Colors.brown,
            fontSize: 25.0));
  }

  Widget customTextField(String fieldName) {
    return Container(
        width: 150.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(fieldName,
              style: TextStyle(
                  fontFamily: 'BalooTammudu',
                  color: Colors.brown,
                  fontSize: 20.0)),
        ));
  }

  /*  --------------------------------------------------------- ANDROID LAYOUT ----------------------------------------------------------------------- */

  Widget androidLayout(LoginState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            child: Opacity(
                opacity: 0.7,
                child: Image(image: AssetImage("images/book2.jpg")))),
        header(),
        Container(
          margin: EdgeInsets.only(bottom: 35.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customTextField("Email :"),
                  Container(
                    width: 190.0,
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
                  customTextField("Password :"),
                  Container(
                    width: 190.0,
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
        Container(child:
        state.status == LoginStatus.inProgress ?
        CircularProgressIndicator() : null),
        loginButton(state),
        createAccountButton()
      ],
    );
  }

  /*  --------------------------------------------------------- WEB LAYOUT ----------------------------------------------------------------------- */

  Widget webLayout(LoginState state) {
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
            header(),
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
            Container(child:
            state.status == LoginStatus.inProgress ?
            CircularProgressIndicator() : null),
            loginButton(state),
            createAccountButton()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        handleState(state);
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 1000) {
            return webLayout(state);
          } else {
            return androidLayout(state);
          }
        });
      }),
    );
  }

  void handleState(LoginState state) {
    if (state.status == LoginStatus.authenticated) {
      Navigator.of(context).pushNamed('/admin');
    } else if(state.status == LoginStatus.unauthenticated) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('authentication failed'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
