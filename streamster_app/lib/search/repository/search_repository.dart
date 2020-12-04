import 'dart:convert';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/my_videos/model/video_item.dart';

enum SearchStatus {
  init,
  loading,
  success,
  emailNotUnique,
  error,
}

class SearchRepository {
  String tag = 'SearchRepository | ';
  RestClient client;

  SearchRepository() {
    this.client = RestClient();
  }

  Future<List<VideoItem>> search({String searchTerm}) async {
    var response = await client.client
        .get(RestClient.searchUrl.toString() + "?searchTerm=$searchTerm");
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return (body as List).map((json) => VideoItem.fromJson(json)).toList();
    } else if (response.statusCode == 400) {
      // No videos match the search term
      return [];
    } else {
      // TODO handle error
      return null;
    }
  }
}
