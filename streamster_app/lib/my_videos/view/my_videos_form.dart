import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_bloc.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_state.dart';
import 'package:streamster_app/my_videos/repository/my_videos_repository.dart';

import 'my_videos_android.dart';
import 'my_videos_web.dart';

class MyVideosForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MyVideosBloc, MyVideosState>(
      listener: (context, state) {
        handleState(state, context);
      },
      child:
          BlocBuilder<MyVideosBloc, MyVideosState>(builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            return MyVideosWeb(state);
          } else {
            return MyVideosAndroid(state);
          }
        });
      }),
    );
  }

  void handleState(MyVideosState state, BuildContext context) {
    if (state.status == MyVideosStatus.success) {
      print(state.videos);
    }
  }
}
