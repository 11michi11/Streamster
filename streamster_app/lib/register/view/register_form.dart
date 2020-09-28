import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streamster_app/login/bloc/login_state.dart';

import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

import 'package:universal_html/prefer_universal/html.dart' as html;

import '../repository/register_repository.dart';

class RegisterFormForWeb extends StatefulWidget {
  @override
  State<RegisterFormForWeb> createState() => _RegisterFormForWebState();
}

class _RegisterFormForWebState extends State<RegisterFormForWeb> {
  final String tag = 'RegisterForm | ';

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  onRegisterButtonPressed(String avatar) {
    print('$tag register btn was pressed');

    BlocProvider.of<RegisterBloc>(context).add(RegisterButtonPressed(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        image: avatar));
  }

  /*  --------------------------------------------------------- COMMON WIDGETS ----------------------------------------------------------------------- */

  Widget defaultImage() {
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

  Widget registerButton(RegisterState state, String image) {
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      child: ButtonTheme(
        minWidth: 180,
        height: 60,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.brown),
              borderRadius: BorderRadius.circular(18.0)),
          color: Colors.white,
          onPressed: () {
            if (state.status != RegistrationStatus.inProgress) {
              onRegisterButtonPressed(image);
            }
          },
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
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /*  --------------------------------------------------------- ANDROID LAYOUT ----------------------------------------------------------------------- */

  File _androidImage;
  String _androidImageEncoded;
  final picker = ImagePicker();

  Future pickImageAndroid() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _androidImage = File(pickedFile.path);

        /* Encode image to String base64 */
        List<int> imageBytes = _androidImage.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        _androidImageEncoded = base64Image;
      }
    });
  }

  Widget showImageAndroid(data) {
    return Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.brown),
            shape: BoxShape.circle,
            image: DecorationImage(fit: BoxFit.fill, image: FileImage(data))));
  }

  Widget androidLayout(RegisterState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(top: 60.0),
          child: Text("Register to Streamster",
              style: TextStyle(
                  fontFamily: 'BalooTammuduBold',
                  color: Colors.brown,
                  fontSize: 25.0)),
        ),
        Column(
          children: [
            FlatButton(
                onPressed: () {
                  pickImageAndroid();
                },
                child: Container(
                  width: 125.0,
                  height: 125.0,
                  child: _androidImage != null
                      ? showImageAndroid(_androidImage)
                      : defaultImage(),
                )),
            Text("upload image",
                style: TextStyle(
                    fontFamily: 'BalooTammuduBold',
                    color: Colors.brown,
                    fontSize: 10.0)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                      width: 200,
                      child: TextField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
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
                      width: 200,
                      child: TextField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                              contentPadding: EdgeInsets.only(top: 10.0),
                              hintText: 'Enter your last name')),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 150.0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text("Email: ",
                              style: TextStyle(
                                  fontFamily: 'BalooTammudu',
                                  color: Colors.brown,
                                  fontSize: 20.0)),
                        )),
                    SizedBox(
                      width: 200,
                      child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                              contentPadding: EdgeInsets.only(top: 10.0),
                              hintText: 'Enter your email')),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 150.0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text("Password: ",
                              style: TextStyle(
                                  fontFamily: 'BalooTammudu',
                                  color: Colors.brown,
                                  fontSize: 20.0)),
                        )),
                    SizedBox(
                      width: 200,
                      child: TextField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                              contentPadding: EdgeInsets.only(top: 10.0),
                              hintText: 'Enter your password')),
                    )],),],),],),
        registerButton(state, _androidImageEncoded)
      ],
    );
  }

  /*  --------------------------------------------------------- WEB LAYOUT ----------------------------------------------------------------------- */

  String imageError;
  String encodedImageWeb;
  Uint8List imageDataWeb;

  pickImageWeb() {
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
      reader.onError.listen((err) => setState(() {
            print("error: ${err.toString()}");
            imageError = err.toString();
          }));
      reader.onLoad.first.then((res) {
        final encoded = reader.result as String;
        final stripped =
            encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        encodedImageWeb = stripped;

        setState(() {
          imageDataWeb = base64.decode(stripped);
          imageError = null;
        });
      });
    });
    input.click();
  }

  Widget showImageWeb(data) {
    return Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.brown),
            shape: BoxShape.circle,
            image:
                DecorationImage(fit: BoxFit.fill, image: MemoryImage(data))));
  }

  Widget webLayout(RegisterState state) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              //Title
              margin: EdgeInsets.only(top: 30.0),
              child: Text("Register to Streamster",
                  style: TextStyle(
                      fontFamily: 'BalooTammuduBold',
                      color: Colors.brown,
                      fontSize: 25.0)),
            ),
            Row(
              //Image view, text 'upload image'
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    FlatButton(
                        onPressed: () {
                          pickImageWeb();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 50.0),
                          width: 100.0,
                          height: 100.0,
                          child: imageDataWeb != null
                              ? showImageWeb(imageDataWeb)
                              : defaultImage(),
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
                  // text fields for name and surname
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
              // text fields for email and password
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
                      )],),],),),
            registerButton(state, encodedImageWeb),
          ],
        ),
      ),
    );
  }

  /*  -------------------------------------------------------------------------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        handleState(state);
      },
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            return webLayout(state);
          } else {
            return androidLayout(state);
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
    } else if (state.status == RegistrationStatus.success) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
        backgroundColor: Colors.green,
      ));
    }
  }
}
