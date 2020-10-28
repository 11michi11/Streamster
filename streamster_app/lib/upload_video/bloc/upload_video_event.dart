
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class UploadVideoEvent extends Equatable {

  const UploadVideoEvent();
}

class UploadVideo extends UploadVideoEvent {

  final String title;
  final String description;
  final List<String> tags;
  final String fileName;
  final Uint8List videoData;

  UploadVideo(this.title, this.description, this.tags, this.fileName, this.videoData);

  @override
  List<Object> get props => [title, description, tags, fileName, videoData];

}