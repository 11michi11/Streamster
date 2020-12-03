import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/search/view/search_android.dart';
import 'package:streamster_app/search/view/search_web.dart';

import '../bloc/search_bloc.dart';
import '../bloc/search_state.dart';
import '../repository/search_repository.dart';

class SearchForm extends StatefulWidget {
  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        handleState(state);
      },
      child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 1100) {
            return SearchWeb(state);
          } else {
            return SearchAndroid(state);
          }
        });
      }),
    );
  }

  void handleState(SearchState state) {
    if (state.status == SearchStatus.error) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('$state.error'),
        backgroundColor: Colors.red,
      ));
    } else if (state.status == SearchStatus.success) {}
  }
}
