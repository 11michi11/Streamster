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

  UploadButton(
      this.state,
      this.context,
      this._titleController,
      this._tagsController,
      this._studyProgramsController,
      this._descriptionController,
      this._languageController,
      this.thumbnail,
      this.video);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 200,
      height: 60,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.brown),
        ),
        color: Colors.brown,
        onPressed: () {
          if (state.status != UploadVideoStatus.uploading) {
            onUploadButtonPressed(
                _titleController.text,
                [_tagsController.text],
                [_studyProgramsController.text],
                _descriptionController.text,
                _languageController.text);
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

  onUploadButtonPressed(String title, List<String> tags,
      List<String> studyPrograms, String description, String language) {
    if (!isEmpty()) {
      if (validateVideoExtension(video.videoExtension)) {
        if (validateThumbnailSize(thumbnail.imageSize)) {
          BlocProvider.of<UploadVideoBloc>(context).add(UploadVideo(
              video.fileName,
              video.videoData,
              new VideoMetadata(
                  title,
                  description,
                  tags,
                  studyPrograms,
                  thumbnail?.imageEncoded ?? null,
                  language,
                  video.videoLength)));
        }
      }
    }
  }

  bool isEmpty() {
    if (_titleController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Title is empty'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else if (_tagsController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Tags are empty'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else if (_studyProgramsController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Study programs are empty'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else if (video == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('No video file uploaded'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else {
      return false;
    }
  }

  bool validateVideoExtension(String videoExtension) {
    var validExtensions = [".mp4"];
    if (validExtensions.contains(videoExtension))
      return true;
    else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Video file format "$videoExtension" is not supported'),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }

  bool validateThumbnailSize(int imageSize) {
    if (imageSize == null) {
      return true;
    } else if (imageSize <= 15000000) {
      return true;
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('This thumbnail is too big. Maximum size is 15MB'),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }
}