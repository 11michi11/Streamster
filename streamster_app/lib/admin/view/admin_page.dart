
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/admin/admin.dart';
import 'package:streamster_app/admin/view/user_list.dart';

class AdminPage extends StatelessWidget {

  final AdminRepository adminRepository;

  const AdminPage({Key key, @required this.adminRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return AdminBloc(adminRepository: adminRepository);
        },
        child: UserList()
      ),
    );
  }
}
