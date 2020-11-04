import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamster_app/upload_video/bloc/upload_video_event.dart';
import 'package:streamster_app/upload_video/bloc/upload_video_state.dart';
import 'package:streamster_app/upload_video/repository/upload_video_repository.dart';

class UploadVideoBloc extends Bloc<UploadVideoEvent, UploadVideoState> {

  final UploadVideoRepository _uploadVideoRepository;

  UploadVideoBloc({@required UploadVideoRepository uploadVideoRepository})
      : assert(uploadVideoRepository != null),
        _uploadVideoRepository = uploadVideoRepository,
        super(const UploadVideoState.init());

  @override
  Stream<UploadVideoState> mapEventToState(UploadVideoEvent event) async* {

    if (event is UploadVideo) {

      yield UploadVideoState.uploading();
      print('yield uploading');

      var response = await _uploadVideoRepository.upload(event.fileName, event.videoData, event.metadata);
      if(response == UploadVideoStatus.success){
        yield UploadVideoState.success();
      } else {
        UploadVideoState.error('error on uploading video');
      }

    }
  }
}