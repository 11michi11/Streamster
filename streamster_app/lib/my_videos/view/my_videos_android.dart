import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_bloc.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_event.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_state.dart';

class MyVideosAndroid extends StatefulWidget {
  final MyVideosState state;

  MyVideosAndroid(this.state);

  @override
  State<StatefulWidget> createState() => _MyVideosAndroidState();
}

class _MyVideosAndroidState extends State<MyVideosAndroid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonTheme(
        minWidth: 200,
        height: 60,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.brown),
              borderRadius: BorderRadius.circular(18.0)),
          color: Colors.white,
          onPressed: () {
            BlocProvider.of<MyVideosBloc>(context).add(GetAllVideos());
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 9.0),
            child: Text('Login',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'BalooTammudu',
                    color: Colors.brown)),
          ),
        ),
      ),
    );
  }
}
