import 'package:streamster_app/upload_video/model/video.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;
import 'dart:io';
import 'package:flutter_video_info/flutter_video_info.dart';


class VideoPicker {

  static Future<Video> pickVideoWeb() async {
    var result;
    final reader = html.FileReader();
    final html.InputElement input = html.document.createElement('input');
    input
      ..type = 'file'
      ..accept = 'video/*';

    input.onChange.listen((e) async {
      if (input.files.isEmpty) {
        print("file is empty");
        return;
      }

      reader.readAsDataUrl(input.files[0]);
      var fileName = input.files[0].name;
      reader.onError.listen((err) => print(err.toString()));

      var videoLength = await getVideoLength(input.files[0].relativePath);

      result = reader.onLoad.first.then((res) {
        final encoded = reader.result as String;
        final stripped =
            encoded.replaceFirst(RegExp(r'data:video/[^;]+;base64,'), '');
        var videoData = base64.decode(stripped);
        var videoSize = videoData.lengthInBytes;

        return new Video(videoData,videoSize,videoLength,fileName);
      });
    });
    input.click();
    final resultReceived = reader.onLoad.first;
    await resultReceived;
    return await result;
  }

  static Future<Video> pickVideoAndroid() async {
    ImagePicker picker = ImagePicker();
    File _androidVideo;
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      _androidVideo = File(pickedFile.path);
      String fileName = _androidVideo.path.split('/').last;
      print('filename: $fileName');

      var videoData = _androidVideo.readAsBytesSync();
      var videoSize = videoData.length;
      var videoLength = await getVideoLength(pickedFile.path);
      fileName =
          'video added'; //pickedFile.path = its returning wrong file name - image_picker8353325253317463941.jpg

      return new Video(videoData, videoSize, videoLength, fileName);
    }
  }

  static Future<double> getVideoLength(String path) async {
    var videoInfo = await FlutterVideoInfo().getVideoInfo(path);
    print("VIDEO DURATION ${videoInfo.duration}");
    return videoInfo.duration;
  }
}
