import 'package:equatable/equatable.dart';
import 'package:streamster_app/my_videos/model/video_item.dart';
import 'package:streamster_app/search/repository/search_repository.dart';

class SearchState extends Equatable {
  final SearchStatus status;
  final List<VideoItem> videos;
  final String error;

  const SearchState._({
    this.status = SearchStatus.init,
    this.videos,
    this.error,
  });

  const SearchState.init() : this._();

  const SearchState.loading() : this._(status: SearchStatus.loading);

  const SearchState.success(List<VideoItem> videos)
      : this._(status: SearchStatus.success, videos: videos);

  const SearchState.error(String message)
      : this._(status: SearchStatus.error, error: message);

  @override
  List<Object> get props => [status, error];

  @override
  String toString() => 'SearchFailure { error: $error }';
}
