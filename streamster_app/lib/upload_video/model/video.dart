import 'dart:typed_data';

class Video {
  Uint8List videoData;
  int videoSize;
  double videoLength;
  String videoExtension;
  String fileName;

  Video(this.videoData, this.videoSize, this.videoLength, this.videoExtension,
      this.fileName);

  @override
  String toString() {
    return 'Video{ videoWebSize: $videoSize, videoLength: $videoLength, videoExtension: $videoExtension, fileName: $fileName}';
  }
}
