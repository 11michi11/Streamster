import 'package:flutter/material.dart';
import 'logout_view.dart';

class LogoutButton extends Logout {
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
