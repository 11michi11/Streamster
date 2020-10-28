
import 'video.dart';

class VideoData {

  Video video;
  String title;
  String description;
  List<String> tags;
  List<String> studyPrograms;
  String thumbnail;
  String language;
  int length;

  VideoData(this.video, this.title, this.description, this.tags,
      this.studyPrograms, this.thumbnail, this.language, this.length);

  @override
  String toString() {
    return 'VideoData{video: ${video.fileName}, title: $title, description: $description, tags: $tags, studyPrograms: $studyPrograms, language: $language, length: $length}';
  }
}
