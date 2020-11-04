import 'dart:io';

class ImageCustom {
  List<int> imageBytes;
  String imageEncoded;
  int imageSize;
  File imageFile;

  ImageCustom(this.imageBytes, this.imageEncoded, this.imageSize, this.imageFile);
}