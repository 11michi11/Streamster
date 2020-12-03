import 'package:equatable/equatable.dart';

abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent();
}

class SavePreferences extends PreferencesEvent {
  final List<String> tags;
  final List<String> studyPrograms;
  final int minLength;
  final int maxLength;

  const SavePreferences(
      this.tags, this.studyPrograms, this.minLength, this.maxLength);

  @override
  List<Object> get props =>
      [this.tags, this.studyPrograms, this.minLength, this.maxLength];

  @override
  String toString() {
    return 'SavePreferences{tags: $tags, studyPrograms: $studyPrograms, minLength: $minLength, maxLength: $maxLength}';
  }
}
