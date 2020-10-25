import 'dart:io';

class Avatar {
  List<int> imageBytes;
  String imageEncoded;
  int imageSize;
  File imageFile;

  Avatar(this.imageBytes, this.imageEncoded, this.imageSize, this.imageFile);
}