import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streamster_app/admin/view/admin_form_android.dart';
import 'package:streamster_app/admin/view/admin_form_web.dart';

class AdminForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 700) {
        return AdminFormWeb();
      } else {
        return AdminFormAndroid();
      }
    });
  }
}
