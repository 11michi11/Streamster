
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/upload_video/upload_video.dart';

class UploadVideoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadVideoBloc, UploadVideoState>(
      listener: (context, state) {
        handleState(state, context);
      },
      child: BlocBuilder<UploadVideoBloc, UploadVideoState>(
          builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            return UploadVideoWeb(state);
          } else {
            return UploadVideoAndroid(state);
          }
        });
      }),
    );
  }

  void handleState(UploadVideoState state, BuildContext context) {
    if(state.status == UploadVideoStatus.success) {
      print('video uploaded successfully');
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Video Uploaded Successfully'),
        backgroundColor: Colors.green,
      ));
    } else if(state.status == UploadVideoStatus.uploading) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Uploading'),
        backgroundColor: Colors.orange,
      ));
      }
      else if(state.status == UploadVideoStatus.error) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('error: ${state.error}'),
          backgroundColor: Colors.red));
    }
  }
}
