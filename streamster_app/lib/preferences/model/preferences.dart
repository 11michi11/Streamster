import 'dart:core';
import 'package:streamster_app/preferences/model/lengthInterval.dart';

class Preferences {

  List<String> tags;
  List<String> studyPrograms;
  LengthInterval interval;

  Preferences(this.tags, this.studyPrograms, this.interval);

  Map toJson() =>
      {
        'tags' : tags,
        'studyPrograms' : studyPrograms,
        'intervalMin' : interval.min,
        'intervalMax' : interval.max
      };
}