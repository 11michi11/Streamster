import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_bloc.dart';
import 'package:streamster_app/my_videos/repository/my_videos_repository.dart';

import 'my_videos_form.dart';

class MyVideosPage extends StatelessWidget {
  final MyVideosRepository myVideosRepository;

  MyVideosPage({Key key, @required this.myVideosRepository})
      : assert(myVideosRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Videos"),
          backgroundColor: Colors.brown,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocProvider(
            create: (context) {
              return MyVideosBloc(myVideosRepository: myVideosRepository);
            },
            child: MyVideosForm()));
  }
}
