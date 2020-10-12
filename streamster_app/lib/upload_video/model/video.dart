import 'dart:convert';

import 'package:universal_html/prefer_universal/html.dart' as html;
import 'dart:typed_data';

class Video {

  String encodedVideoWeb; //String base64
  Uint8List videoDataWeb; //Bytes
  int videoWebSize;
  String fileName;
  String errorMessage;

  Video(this.encodedVideoWeb, this.videoDataWeb, this.videoWebSize,
      this.fileName, this.errorMessage);


  //TODO - this is working but I don't know why - maybe find out how improve it
  Future<Video> pickVideoWeb() async {
    var result;
    final reader = html.FileReader();
    final html.InputElement input = html.document.createElement('input');
    input
      ..type = 'file'
      ..accept = 'video/*';

    input.onChange.listen((e) {
      if (input.files.isEmpty) {
        print("file is empty");
        return;
      }

      reader.readAsDataUrl(input.files[0]);
      this.fileName = input.files[0].name;
      reader.onError.listen((err) => errorMessage = err.toString());

      result = reader.onLoad.first.then((res) {
        final encoded = reader.result as String;
        final stripped =
            encoded.replaceFirst(RegExp(r'data:video/[^;]+;base64,'), '');
        this.encodedVideoWeb = stripped;
        this.videoDataWeb = base64.decode(stripped);
        this.videoWebSize = videoDataWeb.lengthInBytes;
        this.errorMessage = null;

        return new Video(this.encodedVideoWeb, this.videoDataWeb, this.videoWebSize, this.fileName, this.errorMessage);
      });
    });
    input.click();
    final resultReceived = reader.onLoad.first;
    await resultReceived;
    await result;
  }

  @override
  String toString() {
    return 'Video{ videoWebSize: $videoWebSize, fileName: $fileName, errorMessage: $errorMessage}';
  }
}
