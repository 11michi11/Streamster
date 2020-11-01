
import 'dart:typed_data';

class Video {
  Uint8List videoData;
  int videoSize;
  double videoLength;
  String fileName;

  Video(this.videoData, this.videoSize, this.videoLength, this.fileName);

  @override
  String toString() {
    return 'Video{ videoWebSize: $videoSize, videoLength: $videoLength, fileName: $fileName}';
  }
}
