import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/preferences/repository/preferences_repository.dart';
import 'package:streamster_app/register/repository/register_repository.dart';

import '../bloc/preferences_bloc.dart';
import 'preferences_form.dart';

class PreferencesPage extends StatelessWidget {
  final PreferencesRepository preferencesRepository;

  PreferencesPage({Key key, @required this.preferencesRepository})
      : assert(preferencesRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return PreferencesBloc(preferencesRepository: preferencesRepository);
        },
        child: Center(
          child: PreferencesForm(),
        ),
      ),
    );
  }
}
