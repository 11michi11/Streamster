import 'dart:convert';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/my_videos/model/video_item.dart';

enum RecommendationsStatus { init, loading, success, error }

class RecommendationsRepository {

  RestClient client;

  RecommendationsRepository() {
    this.client = RestClient();
  }

  Future<List<VideoItem>> getRecommendations() async {
    var response = await client.client
        .get(RestClient.recommendationsUrl);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      print('RECOMMENDATIONS');
      print(body);
      return (body as List).map((json) => VideoItem.fromJson(json)).toList();
    } else {
      return null;
    }
  }

}
    