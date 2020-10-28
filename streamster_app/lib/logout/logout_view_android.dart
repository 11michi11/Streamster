import 'package:flutter/material.dart';
import 'package:streamster_app/logout/logout_view.dart';

class LogoutAndroid extends Logout {
  @override
  Widget logoutButton(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text('Log out',
            style: TextStyle(
                fontSize: 15, fontFamily: 'BalooTammudu', color: Colors.brown)),
      ),
      onTap: () {
        super.onLogoutButtonPressed(context);
      },
    );
  }
}
