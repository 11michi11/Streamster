
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/watch_video/bloc/feedback_bloc.dart';

import '../watch_video.dart';

class VideoForm extends StatefulWidget {

  final String videoTitle;
  final String avatar;
  final String author;
  final String description;
  final List<String> studyPrograms;
  final List<String> tags;
  final List<String> likedBy;
  final List<String> dislikedBy;
  final String language;
  final String url;
  final String videoId;

  const VideoForm(
      this.videoTitle,
      this.avatar,
      this.author,
      this.description,
      this.studyPrograms,
      this.tags,
      this.language,
      this.url,
      this.videoId,
      this.likedBy,
      this.dislikedBy);

  @override
  State<VideoForm> createState() => _VideoFormState();
}

class _VideoFormState extends State<VideoForm> {
  @override
  Widget build(BuildContext context) {
      return LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 1100) {
          return Container(child: Text('not implemented'));
        } else {
          return VideoFormAndroid(
              widget.videoTitle,
              widget.avatar,
              widget.author,
              widget.description,
              widget.studyPrograms,
              widget.tags,
              widget.language,
              widget.url,
              widget.videoId,
              widget.likedBy,
              widget.dislikedBy);
        }
      });
  }

}