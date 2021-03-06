import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/repository/user_repository.dart';
import 'package:streamster_app/preferences/repository/preferences_repository.dart';
import 'package:streamster_app/preferences/view/preferences_android.dart';
import 'package:streamster_app/preferences/view/preferences_web.dart';

import '../bloc/preferences_bloc.dart';
import '../bloc/preferences_state.dart';

class PreferencesForm extends StatefulWidget {
  final UserRepository userRepository;

  const PreferencesForm({Key key, this.userRepository}) : super(key: key);

  @override
  State<PreferencesForm> createState() => _PreferencesFormState(userRepository);
}

class _PreferencesFormState extends State<PreferencesForm> {
  final UserRepository userRepository;

  _PreferencesFormState(this.userRepository);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreferencesBloc, PreferencesState>(
      listener: (context, state) {
        handleState(state);
      },
      child: BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 1100) {
                return PreferencesWeb(state);
              } else {
                return PreferencesAndroid(state, userRepository);
              }
            });
          }),
    );
  }

  void handleState(PreferencesState state) {
    if (state.status == PreferencesStatus.error) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('$state.error'),
        backgroundColor: Colors.red,
      ));
    } else if (state.status == PreferencesStatus.success) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
        backgroundColor: Colors.green,
      ));
    }
  }
}
