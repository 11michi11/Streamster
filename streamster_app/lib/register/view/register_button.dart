import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/register/bloc/register_state.dart';

import '../register.dart';

class RegisterButton extends StatelessWidget {
  final RegisterState state;
  final BuildContext context;
  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final ImageCustom avatar;
  RegisterButton(this.state, this.context, this._firstNameController, this._lastNameController, this._emailController, this._passwordController, this.avatar);

  RegisterButton(
      this.state,
      this.context,
      this._firstNameController,
      this._lastNameController,
      this._emailController,
      this._passwordController,
      this.avatar);

  onRegisterButtonPressed(ImageCustom avatar) {
    if (!isEmpty()) {
      if (avatar == null || validateImageSize(avatar.imageSize)) {
        if (validateEmail(_emailController.text)) {
          if (validatePassword(_passwordController.text)) {
            BlocProvider.of<RegisterBloc>(context).add(RegisterUser(
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                image: avatar?.imageEncoded ?? null));
          }
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Invalid email'),
            backgroundColor: Colors.red,
          ));
        }
      }
    }
  }

  /*    output:
    Vignesh123 : true
    vignesh123 : false
    VIGNESH123! : false
    vignesh@ : false
    12345678? : false
    */
  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool validatePassword(String password) {
    var isValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(password);
    if (!isValid) {
      var errorMessage = "Invalid password";
      if (password.length < 8) {
        errorMessage = "Password must be at least 8 characters long";
      } else if (!RegExp(r'^(?=.*?[0-9]).{8,}$').hasMatch(password)) {
        errorMessage = "Password must contain at least one digit";
      } else if (!RegExp(r'^(?=.*?[A-Z]).{8,}$').hasMatch(password)) {
        errorMessage = "Password must contain at least one uppercase letter";
      } else if (!RegExp(r'^(?=.*?[a-z]).{8,}$').hasMatch(password)) {
        errorMessage = "Password must contain at least one lowercase letter";
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ));
    }
    return isValid;
  }

  bool validateImageSize(int image) {
    if (image == null) {
      return true;
    } else if (image <= 15000000) {
      return true;
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('This image is too big. Maximum size is 15MB'),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }

  bool isEmpty() {
    if (_firstNameController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Name is empty'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else if (_lastNameController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Surname is empty'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else if (_emailController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Email is empty'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else if (_passwordController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Password is empty'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      child: ButtonTheme(
        minWidth: 180,
        height: 60,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          color: Colors.brown,
          onPressed: () {
            if (state.status != RegistrationStatus.loading) {
              onRegisterButtonPressed(avatar);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text('Register',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'BalooTammudu',
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
