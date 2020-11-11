import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_event.dart';
import 'package:streamster_app/my_videos/repository/my_videos_repository.dart';

import 'my_videos_state.dart';

class MyVideosBloc extends Bloc<MyVideosEvent, MyVideosState> {
  final MyVideosRepository _myVideosRepository;
  final UserRepository _userRepository;

  MyVideosBloc({@required MyVideosRepository myVideosRepository, @required UserRepository userRepository})
      : assert(myVideosRepository != null, userRepository != null),
        _myVideosRepository = myVideosRepository,
        _userRepository = userRepository,
        super(const MyVideosState.init());

  @override
  Stream<MyVideosState> mapEventToState(MyVideosEvent event) async* {
    if (event is GetAllVideos) {
      yield MyVideosState.inProgress();
      var videos = await _myVideosRepository.getAllVideosForCurrentUser();
      var userDetails = await _userRepository.getUserDetailsById(videos[0].authorId);

      if (videos == null) {
        yield MyVideosState.error("Could not get videos");
      } else {
        yield MyVideosState.success(videos, userDetails);
      }
    }
  }
}
