import 'package:flutter/material.dart';

import '../watch_video.dart';

class VideoPage extends StatelessWidget {
  final String videoTitle;
  final String avatar;
  final String author;
  final String description;
  final List<String> studyPrograms;
  final List<String> tags;
  final String language;
  final String url;
  final String videoId;

  VideoPage(this.videoTitle, this.avatar, this.author, this.description, this.studyPrograms, this.tags, this.language, this.url, this.videoId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video"),
        backgroundColor: Colors.brown,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: VideoForm(videoTitle, avatar, author, description, studyPrograms, tags, language, url, videoId),
    );
  }
}