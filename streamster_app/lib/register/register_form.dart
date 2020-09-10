import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/register_bloc.dart';
import 'bloc/register_event.dart';
import 'bloc/register_state.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onRegisterButtonPressed() {
      BlocProvider.of<RegisterBloc>(context).add(RegisterButtonPressed(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text));
    }

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('$state.error'),
            backgroundColor: Colors.red,
          ));
        }
      },
      child:
      BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
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
                        labelText: 'name', labelStyle: TextStyle(fontSize: 25)),
                    controller: _nameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'email',
                        labelStyle: TextStyle(fontSize: 25)),
                    controller: _emailController,
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
                  RaisedButton(
                    onPressed: state is! RegisterInProgress
                        ? _onRegisterButtonPressed
                        : null,
                    child: Text('Register', style: TextStyle(fontSize: 19)),
                  ),
                  Container(
                    child: state is RegisterInProgress
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
