import 'dart:core';

class Preferences {

  List<String> tags;
  List<String> studyPrograms;
  int minLength;
  int maxLength;

  Preferences(this.tags, this.studyPrograms, this.minLength, this.maxLength);

  Map toJson() => {
        'tags': tags,
        'studyPrograms': studyPrograms,
        'minLength': minLength,
        'maxLength': maxLength
      };

  @override
  String toString() {
    return 'Preferences{tags: $tags, studyPrograms: $studyPrograms, minLength: $minLength, maxLength: $maxLength}';
  }
}