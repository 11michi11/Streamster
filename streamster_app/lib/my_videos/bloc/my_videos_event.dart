import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class MyVideosEvent extends Equatable {
  const MyVideosEvent();
}

class GetAllVideos extends MyVideosEvent {
  GetAllVideos();

  @override
  List<Object> get props => [];
}
