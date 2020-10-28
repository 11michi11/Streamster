
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:streamster_app/upload_video/model/video_metadata.dart';

abstract class UploadVideoEvent extends Equatable {

  const UploadVideoEvent();
}

class UploadVideo extends UploadVideoEvent {

  final String fileName;
  final Uint8List videoData;
  final VideoMetadata metadata;

  UploadVideo(this.fileName, this.videoData, this.metadata);

  @override
  List<Object> get props => [fileName, videoData, metadata];

}