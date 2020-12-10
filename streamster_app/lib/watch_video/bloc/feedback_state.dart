import 'package:equatable/equatable.dart';

import '../watch_video.dart';

class FeedbackState extends Equatable {

  final FeedbackStatus status;

  const FeedbackState._({
    this.status = FeedbackStatus.init,
  });

  const FeedbackState.init() : this._();

  const FeedbackState.loading() : this._(status: FeedbackStatus.loading);

  const FeedbackState.success() : this._(status: FeedbackStatus.success);

  const FeedbackState.error() : this._(status: FeedbackStatus.error);

  @override
  List<Object> get props => [status];
}