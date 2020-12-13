import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamster_app/common/repository/user_repository.dart';

import '../watch_video.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {

  final FeedbackRepository _feedbackRepository;
  UserRepository _userRepository = UserRepository();

  FeedbackBloc({@required FeedbackRepository feedbackRepository})
      : assert(FeedbackRepository != null),
        _feedbackRepository = feedbackRepository,
        super(const FeedbackState.init());

  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvent event) async* {
    if (event is LikeEvent) {
      yield FeedbackState.loading();

      if (!event.likedBy.contains(_userRepository.user.id)) {
        // TODo Update local copy of video with new like
        var response =
            await _feedbackRepository.sendLike(videoId: event.videoId);
        if (response == FeedbackStatus.success) {
          yield FeedbackState.success();
        } else {
          yield FeedbackState.error();
        }
      }
    }
  }
}