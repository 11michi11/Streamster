import 'package:flutter/material.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_state.dart';

class MyVideosWeb extends StatefulWidget {
  final MyVideosState state;

  MyVideosWeb(this.state);

  @override
  State<StatefulWidget> createState() => _MyVideosWebState();
}

class _MyVideosWebState extends State<MyVideosWeb> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
