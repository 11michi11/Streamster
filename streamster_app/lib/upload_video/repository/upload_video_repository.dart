import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/upload_video/model/video_metadata.dart';
import 'dart:convert' as convert;

import 'package:streamster_app/upload_video/repository/dummyThumbnail.dart';

enum UploadVideoStatus { init, uploading, success, error }

class UploadVideoRepository {

  RestClient restClient;

  UploadVideoRepository() {
    this.restClient = RestClient();
  }

  Future<UploadVideoStatus> upload(String filename, List<int> bytes, VideoMetadata metadata) async {
    print("sending");
    var request = http.MultipartRequest(
        'POST', RestClient.uploadUrl);
    request.files
        .add(http.MultipartFile.fromBytes('video', bytes, filename: filename,contentType: MediaType.parse("multipart/form-data")));

//    metadata = new VideoMetadata("My new title", "This is a short description", ["Java","C#","Pascal"],
//        ["GBE","ICT"], DummyThumbnail.getThumbnail(), "English", 150);

    request.files.add(http.MultipartFile.fromString("metadata", convert.jsonEncode(metadata.toJson()),contentType:MediaType.parse("application/json")));

    var result = await restClient.client.send(request);
    if(result.statusCode == 201) {
      print("result: $result");
      return UploadVideoStatus.success;
    } else {
      return UploadVideoStatus.error;
    }
  }
}