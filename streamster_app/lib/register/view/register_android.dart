import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../register.dart';

class RegisterAndroid extends StatefulWidget {

  final RegisterState state;
  RegisterAndroid(this.state);

  @override
  State<StatefulWidget> createState() => _RegisterAndroidState();
}

class _RegisterAndroidState extends State<RegisterAndroid> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  ImageCustom avatar;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future pickImage() async {
    var image = await ImagePickerCustom.pickImageAndroid();
    setState(() {
      avatar = image;
    });
  }

  Widget defaultImage() {
    return Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withOpacity(0.4),
                spreadRadius: 30,
                blurRadius: 40,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("images/icon_person.png"))));
  }

  Widget displayImage(data) {
    return Container(
        decoration: BoxDecoration(
            boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.4),
            spreadRadius: 30,
            blurRadius: 40,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
            shape: BoxShape.circle,
            image: DecorationImage(fit: BoxFit.fill, image: FileImage(data))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50.0),
            child: Text("Register Form",
                style: TextStyle(
                    fontFamily: 'BalooTammudu',
                    // color: Color(0xff5d9c84),
                    color: Colors.brown,
                    fontSize: 30.0)),
          ),
          Column(
            children: [
              FlatButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: Container(
                    width: 125.0,
                    height: 125.0,
                    child: avatar != null
                        ? displayImage(avatar.imageFile)
                        : defaultImage(),
                  )),
              Text("click on icon to upload image",
                  style: TextStyle(
                      fontFamily: 'BalooTammuduBold',
                      // color: Color(0xff5d9c84),
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
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text("Name: ",
                                style: TextStyle(
                                    fontFamily: 'BalooTammudu',
                                    // color: Colors.brown,
                                    fontSize: 20.0)),
                          )),
                      SizedBox(
                        width: 200,
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
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text("Surname: ",
                                style: TextStyle(
                                    fontFamily: 'BalooTammudu',
                                    //  color: Colors.brown,
                                    fontSize: 20.0)),
                          )),
                      SizedBox(
                        width: 200,
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
                  Row(
                    children: [
                      Container(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text("Email: ",
                                style: TextStyle(
                                    fontFamily: 'BalooTammudu',
                                    //     color: Colors.brown,
                                    fontSize: 20.0)),
                          )),
                      SizedBox(
                        width: 200,
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
                    children: [
                      Container(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text("Password: ",
                                style: TextStyle(
                                    fontFamily: 'BalooTammudu',
                                    //      color: Colors.brown,
                                    fontSize: 20.0)),
                          )),
                      SizedBox(
                        width: 200,
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
            ],
          ),
          RegisterButton(
              widget.state,
              context,
              _firstNameController,
              _lastNameController,
              _emailController,
              _passwordController,
              avatar)
        ],
      ),
    );
  }
}
