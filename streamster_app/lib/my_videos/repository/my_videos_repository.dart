import 'dart:convert';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/my_videos/model/video_item.dart';

enum MyVideosStatus { init, inProgress, success, error }

class MyVideosRepository {
  RestClient restClient;

  MyVideosRepository() {
    this.restClient = RestClient();
  }

  Future<List<VideoItem>> getAllVideosForCurrentUser() async {
    var response = await restClient.client.get(RestClient.getAllUsersVideosUrl);

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return (body as List).map((json) => VideoItem.fromJson(json)).toList();
    } else if (response.statusCode == 400) {
      // No videos for user
      return [];
    } else {
      // TODO handle error
      print(
          'getAllVideosForCurrentUser: ${response.statusCode}, ${response.body}');
      return null;
    }
  }
}
