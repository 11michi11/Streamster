
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/upload_video/upload_video.dart';
import 'package:streamster_app/upload_video/view/upload_video_android.dart';
import 'package:streamster_app/upload_video/view/upload_video_web.dart';


class UploadVideoForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UploadVideoFormPage();
}

class _UploadVideoFormPage extends State<UploadVideoForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadVideoBloc, UploadVideoState>(
      listener: (context, state) {
        handleState(state);
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

  void handleState(UploadVideoState state) {
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
  }
}
