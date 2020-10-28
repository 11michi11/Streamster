import 'package:equatable/equatable.dart';
import 'package:streamster_app/upload_video/upload_video.dart';

class UploadVideoState extends Equatable {

  final UploadVideoStatus status;
  final String error;

  const UploadVideoState._({
    this.status = UploadVideoStatus.init,
    this.error
  });

  const UploadVideoState.init() : this._();

  const UploadVideoState.uploading() : this._(status: UploadVideoStatus.uploading);

  const UploadVideoState.success() : this._(status: UploadVideoStatus.success);

  const UploadVideoState.error(String message) : this._(status: UploadVideoStatus.error, error: message);

  @override
  List<Object> get props => [status, error];

  @override
  String toString() => 'RegisterFailure { error: $error }';
}