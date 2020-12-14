import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/repository/user_repository.dart';
import 'package:streamster_app/preferences/repository/preferences_repository.dart';

import '../bloc/preferences_bloc.dart';
import 'preferences_form.dart';

class PreferencesPage extends StatelessWidget {
  final PreferencesRepository preferencesRepository;
  final UserRepository userRepository;

  PreferencesPage(
      {Key key,
      @required this.preferencesRepository,
      @required this.userRepository})
      : assert(preferencesRepository != null && userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Preferences"),
        backgroundColor: Colors.brown,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocProvider(
        create: (context) {
          return PreferencesBloc(preferencesRepository: preferencesRepository,
              userRepository: userRepository);
        },
        child: Center(
          child: PreferencesForm(userRepository: userRepository),
        ),
      ),
    );
  }
}
