class VideoItem {
  String id;
  String authorId;
  String authorName;
  String description;
  String language;
  String title;
  String thumbnail;
  int length;
  List<String> studyPrograms;
  List<String> tags;
  List<String> likedBy;
  List<String> dislikedBy;

  VideoItem.fromJson(Map json) {
    this.id = json['id'];
    this.authorId = json['authorId'];
    this.authorName = json['authorName'];
    this.description = json['description'];
    this.language = json['language'];
    this.title = json['title'];
    this.thumbnail = json['thumbnail'];
    this.studyPrograms =
        (json['studyPrograms'] as List<dynamic>).cast<String>();
    this.tags = (json['tags'] as List<dynamic>).cast<String>();
    this.length = json['length'] as int;
    this.likedBy = (json['likedBy'] as List<dynamic>).cast<String>();
    this.dislikedBy = (json['dislikedBy'] as List<dynamic>).cast<String>();
  }

  @override
  String toString() {
    return 'VideoItem{id: $id, authorId: $authorId, authorName: $authorName, description: $description, language: $language, title: $title, thumbnail: $thumbnail, length: $length, studyPrograms: $studyPrograms, tags: $tags, likedBy: $likedBy, dislikedBy: $dislikedBy}';
  }
}
