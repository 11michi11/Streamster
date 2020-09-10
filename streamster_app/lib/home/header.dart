import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .width * 0.15,
      child: Center(
        child: Text(
          "Film Master",
          style: TextStyle(fontFamily: 'Dreamwood', fontSize: 40),
        ),
      ),
    );
  }
}
