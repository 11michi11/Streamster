import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/recommendations/repository/recommendations_repository.dart';

import 'recommendations_event.dart';
import 'recommendations_state.dart';

class RecommendationsBloc
    extends Bloc<RecommendationsEvent, RecommendationsState> {

  final UserRepository _userRepository;
  final RecommendationsRepository _recommendationsRepository;

  RecommendationsBloc(
      {@required RecommendationsRepository recommendationsRepository, @required UserRepository userRepository})
      : assert(recommendationsRepository != null, userRepository != null),
        _recommendationsRepository = recommendationsRepository,
        _userRepository = userRepository,
        super(const RecommendationsState.init());

  @override
  Stream<RecommendationsState> mapEventToState(
      RecommendationsEvent event) async* {

    if(event is GetRecommendations) {
      yield RecommendationsState.loading();
      List<User> users = new List();
      var videos = await _recommendationsRepository.getRecommendations();

      if(videos == null) {
        yield RecommendationsState.error();
      } else {
        for(var video in videos) {
          var user = await _userRepository.getUserDetailsById(video.authorId);
          users.add(user);
        }
        yield RecommendationsState.success(videos, users);
      }
    }
  }
}