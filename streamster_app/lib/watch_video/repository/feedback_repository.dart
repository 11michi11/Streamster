import 'package:meta/meta.dart';
import 'package:streamster_app/common/common.dart';

enum FeedbackStatus { init, loading, success, error }

class FeedbackRepository {

  RestClient client;

  FeedbackRepository() {
    this.client = RestClient();
  }

  Future<FeedbackStatus> sendLike({@required String videoId}) async {
    var response = await client.client
        .get(RestClient.feedbackLikeUrl.toString() + "$videoId/like");
    if (response.statusCode == 200) {
      return FeedbackStatus.success;
    } else {
      return FeedbackStatus.error;
    }
  }

}
    