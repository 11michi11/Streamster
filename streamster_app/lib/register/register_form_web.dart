import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/register_bloc.dart';
import 'bloc/register_event.dart';
import 'bloc/register_state.dart';

import 'package:universal_html/prefer_universal/html.dart' as html;

import 'repository/register_repository.dart';

class RegisterFormForWeb extends StatefulWidget {
  @override
  State<RegisterFormForWeb> createState() => _RegisterFormForWebState();
}

class _RegisterFormForWebState extends State<RegisterFormForWeb> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String imageName = '';
  String imageError;
  String encodedImage;
  Uint8List imageData;

  _onRegisterButtonPressed() {
    BlocProvider.of<RegisterBloc>(context).add(RegisterButtonPressed(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        image: encodedImage));
  }

  pickImage() {
    final html.InputElement input = html.document.createElement('input');
    input
      ..type = 'file'
      ..accept = 'image/*';

    input.onChange.listen((e) {
      if (input.files.isEmpty) {
        print("file is empty");
        return;
      }
      final reader = html.FileReader();
      reader.readAsDataUrl(input.files[0]);
      reader.onError.listen((err) =>
          setState(() {
            print("error: ${err.toString()}");
            imageError = err.toString();
          }));
      reader.onLoad.first.then((res) {
        final encoded = reader.result as String;
        // remove data:image/*;base64 preambule
        print("encoded");
        final stripped = encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        print("stripped: ${stripped}");
        encodedImage = stripped;

        setState(() {
          imageName = input.files[0].name;
          imageData = base64.decode(stripped);
          imageError = null;
          print('state is set: ' + imageName + " | data: " +
              imageData.toString());
        });
      });
    });

    input.click();
  }

  Widget _defaultImage() {
    return Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.brown),
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQhOaaBAY_yOcJXbL4jW0I_Y5sePbzagqN2aA&usqp=CAU"))));
  }

  Widget _showImage(data) {
    return Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.brown),
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: MemoryImage(data))));
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status == RegistrationStatus.error) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('$state.error'),
            backgroundColor: Colors.red,
          ));
        } else if (state.status == RegistrationStatus.success) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('success'),
            backgroundColor: Colors.red,
          ));
        }
      },
      child:
      BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        return Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.50,
          height: MediaQuery
              .of(context)
              .size
              .height,
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: Text("Register to Streamster",
                      style: TextStyle(
                          fontFamily: 'BalooTammuduBold',
                          color: Colors.brown,
                          fontSize: 25.0)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        FlatButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 50.0),
                              width: 100.0,
                              height: 100.0,
                              child:
                              imageData != null
                                  ? _showImage(imageData)
                                  : _defaultImage(),
                            )),
                        Container(
                          margin: EdgeInsets.only(right: 50.0),
                          child: Text("upload image",
                              style: TextStyle(
                                  fontFamily: 'BalooTammuduBold',
                                  color: Colors.brown,
                                  fontSize: 10.0)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 150.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text("Name: ",
                                      style: TextStyle(
                                          fontFamily: 'BalooTammudu',
                                          color: Colors.brown,
                                          fontSize: 20.0)),
                                )),
                            SizedBox(
                              width: 235,
                              child: TextField(
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                      hintStyle:
                                      TextStyle(fontFamily: 'BalooTammudu'),
                                      contentPadding: EdgeInsets.only(top: 10.0),
                                      hintText: 'Enter your first name')),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                width: 150.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text("Surname: ",
                                      style: TextStyle(
                                          fontFamily: 'BalooTammudu',
                                          color: Colors.brown,
                                          fontSize: 20.0)),
                                )),
                            SizedBox(
                              width: 235,
                              child: TextField(
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                      hintStyle:
                                      TextStyle(fontFamily: 'BalooTammudu'),
                                      contentPadding: EdgeInsets.only(top: 10.0),
                                      hintText: 'Enter your last name')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
                          SizedBox(
                            width: 235,
                            child: TextField(
                                obscureText: true,
                                controller: _emailController,
                                decoration: InputDecoration(
                                    hintStyle:
                                    TextStyle(fontFamily: 'BalooTammudu'),
                                    contentPadding: EdgeInsets.only(top: 10.0),
                                    hintText: 'Enter your email')),
                          )
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
                          SizedBox(
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
                  margin: EdgeInsets.only(bottom: 50.0),
                  child: ButtonTheme(
                    minWidth: 180,
                    height: 60,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.brown),
                          borderRadius: BorderRadius.circular(18.0)),
                      color: Colors.white,
                      onPressed: state.status != RegistrationStatus.inProgress
                        ? _onRegisterButtonPressed
                        : null,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13.0),
                        child: Text('Register',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'BalooTammudu',
                                color: Colors.brown)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
