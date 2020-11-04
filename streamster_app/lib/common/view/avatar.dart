import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Avatar {

 static Widget defaultAvatar(size) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/person_grey_icon.png'))));
  }

  static Widget setAvatar(size, encodedImage) {
    Uint8List bytes = base64Decode(encodedImage);
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image:
            DecorationImage(fit: BoxFit.fill, image: MemoryImage(bytes))));
  }
}