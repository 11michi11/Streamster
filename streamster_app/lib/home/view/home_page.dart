import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/repository/user_repository.dart';
import 'package:streamster_app/home/bloc/home_bloc.dart';
import 'package:streamster_app/home/bloc/home_state.dart';
import 'package:streamster_app/logout/bloc/logout_bloc.dart';
import 'package:streamster_app/search/repository/search_repository.dart';

import 'home_form_android.dart';
import 'home_form_web.dart';

class HomePage extends StatelessWidget {
  final UserRepository userRepository;
  final SearchRepository searchRepository;

  const HomePage({Key key, this.userRepository, this.searchRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (BuildContext context) => HomeBloc(),
          ),
          BlocProvider<LogoutBloc>(
            create: (BuildContext context) => LogoutBloc(),
          ),
        ],
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 1000) {
              return HomeFormWeb();
            } else {
              return HomeFormAndroid(
                userRepository: userRepository,
                searchRepository: searchRepository,
              );
            }
          });
        }),
      ),
    );
  }
}
