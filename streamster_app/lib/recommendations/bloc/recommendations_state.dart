import 'package:equatable/equatable.dart';
import 'package:streamster_app/common/model/user.dart';
import 'package:streamster_app/my_videos/model/video_item.dart';
import 'package:streamster_app/recommendations/repository/recommendations_repository.dart';

class RecommendationsState extends Equatable {

  final RecommendationsStatus status;
  final List<User> users;
  final List<VideoItem> videos;

  const RecommendationsState._({
    this.status = RecommendationsStatus.init,
    this.users,
    this.videos
  });

  const RecommendationsState.init() : this._();

  const RecommendationsState.loading()
      : this._(status: RecommendationsStatus.loading);

  const RecommendationsState.success(List<VideoItem> videos, List<User> userDetails)
      : this._(status: RecommendationsStatus.success, users: userDetails, videos: videos);

  const RecommendationsState.error()
      : this._(status: RecommendationsStatus.error);

  @override
  List<Object> get props => [status];
}