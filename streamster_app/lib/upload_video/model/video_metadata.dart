

import 'package:flutter/cupertino.dart';

class VideoMetadata {

  String title;
  String description;
  List<String> tags;
  List<String> studyPrograms;
  String thumbnail;
  String language;
  int length;

  VideoMetadata(this.title, this.description, this.tags,
      this.studyPrograms, this.thumbnail, this.language, this.length);

  Map toJson() =>
      {
        'title': title,
        'description': description,
        'tags': tags,
        'studyPrograms': studyPrograms,
        'thumbnail': thumbnail,
        'language': language,
        'length': length
      };

  @override
  String toString() {
    return 'VideoData{title: $title, description: $description, tags: $tags, studyPrograms: $studyPrograms, language: $language, length: $length}';
  }
}
