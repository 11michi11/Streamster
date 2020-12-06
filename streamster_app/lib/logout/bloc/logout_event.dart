import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();
}

class LogoutUser extends LogoutEvent {
  @override
  List<Object> get props => [];
}
