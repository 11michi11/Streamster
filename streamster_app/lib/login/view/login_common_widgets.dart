import 'package:flutter/material.dart';

class LoginCommonWidgets {
  static Widget header() {
    return Text("Login to Streamster",
        style: TextStyle(
            fontFamily: 'BalooTammuduBold',
            color: Colors.brown,
            fontSize: 25.0));
  }

  static Widget customTextField(String fieldName) {
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

  static Widget createAccountButton(BuildContext context) {
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
}
