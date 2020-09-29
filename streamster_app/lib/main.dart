import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/admin/admin.dart';
import 'package:streamster_app/login/repository/login_repository.dart';
import 'package:streamster_app/register/repository/register_repository.dart';
import 'admin/view/admin_page.dart';
import 'common/common.dart';
import 'login/login.dart';
import 'register/bloc/register_bloc.dart';
import 'register/view/register_page.dart';

void main() {
  final loginRepository = LoginRepository();
  final userRepository = UserRepository();
  final registerRepository = RegisterRepository();
  final adminRepository = AdminRepository();

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<LoginBloc>(
        create: (context) {
          return LoginBloc(loginRepository: loginRepository);
        },
      ),
      BlocProvider<RegisterBloc>(
        create: (context) {
          return RegisterBloc(registerRepository: registerRepository);
        },
      ),
      BlocProvider<AdminBloc>(
        create: (context) {
          return AdminBloc(adminRepository: adminRepository);
        },
      ),
    ], child: App(userRepository: userRepository, loginRepository: loginRepository, registerRepository: registerRepository, adminRepository : adminRepository),)
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final LoginRepository loginRepository;
  final RegisterRepository registerRepository;
  final AdminRepository adminRepository;

  App(
      {Key key,
      @required this.userRepository,
      @required this.loginRepository,
      @required this.registerRepository,
      @required this.adminRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilmMaster',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/login': (context) => LoginPage(loginRepository: loginRepository),
        '/register': (context) =>
            RegisterPage(registerRepository: registerRepository),
        '/admin' : (context) => AdminPage(adminRepository: adminRepository),
      },
      initialRoute: '/login',
    );
  }
}
