import 'package:equatable/equatable.dart';
import 'package:streamster_app/common/model/user.dart';
import 'package:streamster_app/login/repository/login_repository.dart';

enum LogoutStatus { unknown, inProgress, success }

class LogoutState extends Equatable {
  final LogoutStatus status;

  const LogoutState._({this.status = LogoutStatus.unknown});

  const LogoutState.unknown() : this._(status: LogoutStatus.unknown);

  const LogoutState.inProgress() : this._(status: LogoutStatus.inProgress);

  const LogoutState.success() : this._(status: LogoutStatus.success);

  @override
  List<Object> get props => [];
}
