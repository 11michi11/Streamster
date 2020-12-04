import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/search/repository/search_repository.dart';

import '../bloc/search_bloc.dart';
import 'search_form.dart';

class SearchPage extends StatelessWidget {
  final SearchRepository searchRepository;

  SearchPage({Key key, @required this.searchRepository})
      : assert(searchRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Colors.brown,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocProvider(
        create: (context) {
          return SearchBloc(searchRepository: searchRepository);
        },
        child: SearchForm(),
      ),
    );
  }
}
