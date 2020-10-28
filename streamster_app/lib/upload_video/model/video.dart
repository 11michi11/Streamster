
import 'dart:typed_data';

class Video {
  Uint8List videoData;
  int videoSize;
  String fileName;

  Video(this.videoData, this.videoSize, this.fileName);

  @override
  String toString() {
    return 'Video{ videoWebSize: $videoSize, fileName: $fileName}';
  }
}
