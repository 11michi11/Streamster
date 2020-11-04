
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../register.dart';

class RegisterWeb extends StatefulWidget {

  final RegisterState state;
  RegisterWeb(this.state);

  @override
  State<StatefulWidget> createState() => _RegisterWebState();
}

class _RegisterWebState extends State<RegisterWeb> {

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
            image:
            DecorationImage(fit: BoxFit.fill, image: MemoryImage(data))));
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

  Future pickImage() async{
    var image = await ImagePickerCustom.pickImageWeb();
    print("image : $image");
    setState(() {
      avatar = image;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          pickImage();
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 50.0),
                            width: 120.0,
                            height: 120.0,
                            child: avatar != null
                                ? displayImage(avatar.imageBytes)
                                : defaultImage()
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
              ],
            ),
            Container(
              // text fields for name, surname, email and password
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 20.0),
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
                      )
                    ],),
                ],),),
            RegisterButton(widget.state, context, _firstNameController, _lastNameController, _emailController, _passwordController, avatar),
          ],
        ),
      ),
    );
  }

}
