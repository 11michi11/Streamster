import 'dart:convert';
import 'dart:io';
import 'package:streamster_app/register/model/Image.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;
import 'package:image_picker/image_picker.dart';

class ImageFilePicker {

  static Future<Image> pickImageWeb() async {
    var result;
    final reader = html.FileReader();
    final html.InputElement input = html.document.createElement('input');
    input
      ..type = 'file'
      ..accept = 'image/*';

    input.onChange.listen((e) {
      if (input.files.isEmpty) {
        print("file is empty");
        return;
      }
      reader.readAsDataUrl(input.files[0]);
      reader.onError.listen((err) =>
            print("error: ${err.toString()}"));

      result = reader.onLoad.first.then((res) {
        final encoded = reader.result as String;
        final stripped =
            encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        var imageEncoded = stripped;
        var imageBytes = base64.decode(stripped);
        return new Image(imageBytes, imageEncoded, imageBytes.lengthInBytes);
      });
    });
    input.click();
    final resultReceived = reader.onLoad.first;
    await resultReceived;
    await result;
  }

  static Future<Image> pickImageAndroid() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      var androidImage = File(pickedFile.path);
      /* Encode image to String base64 */
      List<int> imageBytes = androidImage.readAsBytesSync();
      var imageSize = imageBytes.length;
      print('image lenght: ${imageBytes.length}');

      String base64Image = base64Encode(imageBytes);
      var imageEncoded = base64Image;
      return new Image(imageBytes, imageEncoded,imageSize);
    } else {
      // Handle error
    }
  }
}
