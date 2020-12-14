import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/common/model/image_custom.dart';
import 'package:streamster_app/upload_video/bloc/upload_video_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/upload_video/model/video.dart';
import 'package:streamster_app/upload_video/model/video_metadata.dart';
import '../upload_video.dart';

class UploadButton extends StatelessWidget {
  final UploadVideoState state;
  final BuildContext context;
  final String title;
  final List<String> tags;
  final List<String> studyPrograms;
  final String description;
  final String language;
  final ImageCustom thumbnail;
  final Video video;

  UploadButton(
      this.state,
      this.context,
      this.title,
      this.tags,
      this.studyPrograms,
      this.description,
      this.language,
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
                title,
                tags,
                studyPrograms,
                description,
                language);
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
        if (validateThumbnailSize(thumbnail.imageSize)) {
          var programs = setStudyPrograms(studyPrograms);
          BlocProvider.of<UploadVideoBloc>(context).add(UploadVideo(
              video.fileName,
              video.videoData,
              new VideoMetadata(
                  title,
                  description,
                  tags,
                  programs,
                  thumbnail?.imageEncoded ?? null,
                  language,
                  video.videoLength)));
        }
    }
  }

  bool isEmpty() {
    if (title.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Title must be specified'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else if (tags.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('At least one tag must be specified'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else if (studyPrograms.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('At least one study program must be specified'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else if (video == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('No video file uploaded'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else if (thumbnail == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('No thumbnail uploaded'),
        backgroundColor: Colors.red,
      ));
      return true;
    } else {
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

  List<String> setStudyPrograms(studyPrograms) {
    List<String> programs = new List();

    for(var studyProgram in studyPrograms) {
      var program = convertStudyProgram(studyProgram);
      programs.add(program);
    }

    return programs;
  }

  String convertStudyProgram(program) {
    switch (program) {
      case 'Global Business Engineering':
        return StudyPrograms.GBE.program;
      case 'Software Engineering':
        return StudyPrograms.ICT.program;
      case 'Mechanical Engineering':
        return StudyPrograms.ME.program;
      case 'Civil Engineering':
        return StudyPrograms.CE.program;
      case 'Marketing Management':
        return StudyPrograms.MM.program;
      case 'Value Chain':
        return StudyPrograms.VCE.program;
      default:
        return null;
    }
  }
}