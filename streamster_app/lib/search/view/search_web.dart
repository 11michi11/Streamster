import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../search.dart';

class SearchWeb extends StatefulWidget {
  final SearchState state;

  SearchWeb(this.state);

  @override
  State<StatefulWidget> createState() => _SearchWebState();
}

class _SearchWebState extends State<SearchWeb> {
  final _searchTermController = TextEditingController();

  @override
  void dispose() {
    _searchTermController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
