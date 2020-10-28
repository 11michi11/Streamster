import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streamster_app/common/model/image_custom.dart';
import 'package:streamster_app/upload_video/bloc/upload_video_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/upload_video/model/video.dart';
import 'package:streamster_app/upload_video/model/video_metadata.dart';

import '../upload_video.dart';

class UploadButton extends StatelessWidget {

  final UploadVideoState state;
  final BuildContext context;
  final TextEditingController _titleController;
  final TextEditingController _tagsController;
  final TextEditingController _studyProgramsController;
  final TextEditingController _descriptionController;
  final TextEditingController _languageController;
  final ImageCustom thumbnail;
  final Video video;

  UploadButton(this.state, this.context, this._titleController, this._tagsController,
      this._studyProgramsController, this._descriptionController,
      this._languageController, this.thumbnail, this.video);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 200,
      height: 60,
      child: FlatButton(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.brown),),
        color: Colors.brown,
        onPressed: () {
          if (state.status != UploadVideoStatus.uploading) {
            onUploadButtonPressed(
                _titleController.text, [_tagsController.text], [_studyProgramsController.text],
                _descriptionController.text, _languageController.text);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text('Submit',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'BalooTammudu',
                  color: Colors.white)),
        ),
      ),
    );
  }

  onUploadButtonPressed(String title, List<String> tags, List<String> studyPrograms, String description, String language) {
    BlocProvider.of<UploadVideoBloc>(context).add(
        UploadVideo(video.fileName, video.videoData, new VideoMetadata(title, description, tags, studyPrograms, thumbnail?.imageEncoded ?? null, language, 0)));
  }
}