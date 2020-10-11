
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/admin/admin.dart';
import 'package:streamster_app/admin/view/user_list.dart';
import 'package:streamster_app/common/common.dart';

class AdminPage extends StatelessWidget {

  final AdminRepository adminRepository;
  final UserRepository userRepository;

  const AdminPage({Key key, @required this.adminRepository, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return AdminBloc(adminRepository: adminRepository, userRepository: userRepository);
        },
        child: UserList()
      ),
    );
  }
}
