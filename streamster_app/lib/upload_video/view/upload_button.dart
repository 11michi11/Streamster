import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streamster_app/upload_video/bloc/upload_video_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/upload_video/model/video.dart';

import '../upload_video.dart';

class UploadButton extends StatelessWidget {

  final UploadVideoState state;
  final BuildContext context;
  final TextEditingController _tagsController;
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;
  final Video video;

  UploadButton(this.state, this.context,this._tagsController, this._titleController, this._descriptionController, this.video);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 200,
      height: 60,
      child: FlatButton(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.brown),),
        color: Colors.white,
        onPressed: () {
          if (state.status != UploadVideoStatus.uploading) {
            List<String> tags = new List<String>();
            tags.add(_tagsController.text);
            onUploadButtonPressed(
                _titleController.text, _descriptionController.text, tags);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text('Submit',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'BalooTammudu',
                  color: Colors.brown)),
        ),
      ),
    );
  }

  onUploadButtonPressed(String title, String description, List<String> tags) {
    BlocProvider.of<UploadVideoBloc>(context).add(
        UploadVideo(title, description, tags, video.fileName, video.videoData));
  }
}