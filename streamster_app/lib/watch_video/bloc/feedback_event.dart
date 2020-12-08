import 'package:equatable/equatable.dart';

abstract class FeedbackEvent extends Equatable {

  const FeedbackEvent();

}

class LikeEvent extends FeedbackEvent {

  final String videoId;

  LikeEvent(this.videoId);

  @override
  List<Object> get props => [videoId];

}

class DislikeEvent extends FeedbackEvent {

  final String videoId;

  DislikeEvent(this.videoId);

  @override
  List<Object> get props => [videoId];

}

class CommentEvent extends FeedbackEvent {

  final String videoId;
  final String message;
  final bool isCommentPositive;

  CommentEvent(this.videoId, this.message, this.isCommentPositive);

  @override
  List<Object> get props => [videoId, message];


}