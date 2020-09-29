import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../admin.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {

  final AdminRepository _adminRepository;

  AdminBloc({@required AdminRepository adminRepository})
      : assert(adminRepository != null),
        _adminRepository = adminRepository,
        super(const AdminState.init());

  @override
  Stream<AdminState> mapEventToState(AdminEvent event) async* {

    if(event is GetUsers) {
    }
    else if(event is UpdateSystemRole) {

    }
  }
}
