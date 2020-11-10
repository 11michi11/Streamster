import 'package:equatable/equatable.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/my_videos/model/video_item.dart';
import 'package:streamster_app/my_videos/repository/my_videos_repository.dart';

class MyVideosState extends Equatable {
  final MyVideosStatus status;
  final User user;
  final String error;
  final List<VideoItem> videos;

  const MyVideosState._(
      {this.status = MyVideosStatus.init, this.user,this.error, this.videos});

  const MyVideosState.init() : this._();

  const MyVideosState.inProgress() : this._(status: MyVideosStatus.inProgress);

  const MyVideosState.success(List<VideoItem> videos, User userDetails)
      : this._(status: MyVideosStatus.success, user: userDetails, videos: videos);

  const MyVideosState.error(String message)
      : this._(status: MyVideosStatus.error, error: message);

  @override
  List<Object> get props => [status, error];

  @override
  String toString() => 'RegisterFailure { error: $error }';
}
