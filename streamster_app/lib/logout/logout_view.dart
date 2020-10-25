import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/repository/user_repository.dart';
import 'package:streamster_app/logout/logout_event.dart';
import 'package:streamster_app/logout/logout_state.dart';

import 'logout_bloc.dart';

class Logout extends StatelessWidget {
  final UserRepository userRepository;

  Logout({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        handleState(state, context);
      },
      child: logoutButton(context),
    );
  }

  Widget logoutButton(BuildContext context) {
    return ButtonTheme(
      minWidth: 180,
      height: 60,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.brown),
            borderRadius: BorderRadius.circular(18.0)),
        color: Colors.white,
        onPressed: () {
          onLogoutButtonPressed(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 9.0),
          child: Text('Logout',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'BalooTammudu',
                  color: Colors.brown)),
        ),
      ),
    );
  }

  void onLogoutButtonPressed(BuildContext context) {
    BlocProvider.of<LogoutBloc>(context).add(LogoutUser());
  }

  void handleState(LogoutState state, BuildContext context) {
    switch (state.status) {
      case LogoutStatus.success:
        Navigator.of(context).pushNamed('/login');
        break;
      case LogoutStatus.unknown:
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Logout is currently not available'),
          backgroundColor: Colors.yellow,
        ));
        break;
      case LogoutStatus.inProgress:
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Logout in progress'),
          backgroundColor: Colors.yellow,
        ));
        break;
    }
  }
}
