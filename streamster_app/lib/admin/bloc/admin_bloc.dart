import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamster_app/common/common.dart';

import '../admin.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository _adminRepository;
  final UserRepository _userRepository;

  AdminBloc(
      {@required AdminRepository adminRepository,
      @required UserRepository userRepository})
      : assert(adminRepository != null, userRepository != null),
        _adminRepository = adminRepository,
        _userRepository = userRepository,
        super(const AdminState.init());

  @override
  Stream<AdminState> mapEventToState(AdminEvent event) async* {
    if (event is GetUsers) {

      var response = await _userRepository.getAllUsers();
      yield AdminState.getUsers(response);

    } else if (event is UpdateSystemRole) {

      var response = await _adminRepository.updateSystemRole(
          userID: event.userId, systemRole: event.systemRole);

      if (response == AdminStatus.updateSuccessful) {
        yield AdminState.updateSuccessful();
        var response = await _userRepository.getAllUsers();
        yield AdminState.getUsers(response);
      } else {
        yield AdminState.error('Error during update');
      }
    }
  }
}
