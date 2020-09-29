
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:streamster_app/admin/model/user.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
}

class UpdateSystemRole extends AdminEvent {
  final String userId;
  final String systemRole;

  UpdateSystemRole({@required this.userId, @required this.systemRole});

  @override
  List<Object> get props => [userId, systemRole];

}

class GetUsers extends AdminEvent {

  @override
  List<Object> get props => [];
}
