import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/logout_event.dart';
import '../bloc/logout_state.dart';

class LogoutButtonWidget extends StatelessWidget {
  LogoutButtonWidget();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogoutBloc>(
      create: (context) {
        return LogoutBloc();
      },
      child: BlocListener<LogoutBloc, LogoutState>(
        listener: (context, state) {
          handleState(state, context);
        },
        child: BlocBuilder<LogoutBloc, LogoutState>(
          builder: (context, state) {
            return ButtonTheme(
              minWidth: 180,
              height: 60,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('Log out',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'BalooTammudu',
                          color: Colors.brown)),
                ),
                onTap: () {
                  BlocProvider.of<LogoutBloc>(context).add(LogoutUser());
                },
              ),
            );
          },
        ),
      ),
    );
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
