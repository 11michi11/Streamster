import 'package:http/http.dart' as http;
import 'package:streamster_app/common/common.dart';

enum UploadVideoStatus { init, uploading, success, error }

class UploadVideoRepository {

  RestClient restClient;

  UploadVideoRepository() {
    this.restClient = RestClient();
  }

  Future<UploadVideoStatus> upload(List<int> bytes, String filename) async {
    print("sending");
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://localhost:8080/video-service/upload"));
    request.files
        .add(http.MultipartFile.fromBytes('video', bytes, filename: filename));
    var result = await restClient.client.send(request);
    if(result.statusCode == 201) {
      print("result: $result");
      return UploadVideoStatus.success;
    } else {
      return UploadVideoStatus.error;
    }

  }
}