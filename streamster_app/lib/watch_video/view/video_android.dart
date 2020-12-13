
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/watch_video/view/like_widget.dart';
import 'package:streamster_app/watch_video/view/video_widget.dart';
import 'package:video_player/video_player.dart';

import '../watch_video.dart';

class VideoFormAndroid extends StatefulWidget {
  final String videoTitle;
  final String avatar;
  final String author;
  final String description;
  final List<String> studyPrograms;
  final List<String> tags;
  final List<String> likedBy;
  final List<String> dislikedBy;
  final String language;
  final String url;
  final String videoId;

  VideoFormAndroid(
      this.videoTitle,
      this.avatar,
      this.author,
      this.description,
      this.studyPrograms,
      this.tags,
      this.language,
      this.url,
      this.videoId,
      this.likedBy,
      this.dislikedBy)
      : super();

  @override
  State<StatefulWidget> createState() => _VideoFormAndroidState();
}

class _VideoFormAndroidState extends State<VideoFormAndroid> {
  bool isExtended = false;
  String url, description, language, author;
  FeedbackRepository repository = new FeedbackRepository();

  _VideoFormAndroidState();

  Widget videoDataExtendedSection() {
    return Container(
      height: 250,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Text("author",
                  style: TextStyle(
                      fontFamily: 'BalooTammuduBold',
                      color: Colors.brown,
                      fontSize: 15)),
              Text(author,
                  style: TextStyle(
                      fontFamily: 'BalooTammudu',
                      color: Colors.black54,
                      fontSize: 17)),
              Text("description",
                  style: TextStyle(
                      fontFamily: 'BalooTammuduBold',
                      color: Colors.brown,
                      fontSize: 15)),
              Text(description,
                  style: TextStyle(
                    fontFamily: 'BalooTammudu',
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center),
              Text("study programs",
                  style: TextStyle(
                      fontFamily: 'BalooTammuduBold',
                      color: Colors.brown,
                      fontSize: 15)),
              Text(formatListData(widget.studyPrograms),
                  style: TextStyle(
                      fontFamily: 'BalooTammudu',
                      color: Colors.black54,
                      fontSize: 15)),
              Text("tags",
                  style: TextStyle(
                      fontFamily: 'BalooTammuduBold',
                      color: Colors.brown,
                      fontSize: 15)),
              Text(formatListData(widget.tags),
                  style: TextStyle(
                      fontFamily: 'BalooTammudu',
                      color: Colors.black54,
                      fontSize: 15)),
              Text("language",
                  style: TextStyle(
                      fontFamily: 'BalooTammuduBold',
                      color: Colors.brown,
                      fontSize: 15)),
              Text(language,
                  style: TextStyle(
                      fontFamily: 'BalooTammudu',
                      color: Colors.black54,
                      fontSize: 15)),
            ],
          );
        },
      ),
    );
  }

  Widget commentSection() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width * 0.85,
            child: Divider(color:  Colors.blueGrey)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LikeWidget(feedbackRepository: repository,
                videoId: widget.videoId,
                likedBy: widget.likedBy,
                dislikedBy: widget.dislikedBy),
            FlatButton(onPressed: () {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Comments are not implemented'),
                backgroundColor: Colors.blueGrey,
              ));
            },
                child: Icon(
                    Icons.comment_outlined, color: Colors.brown, size: 36))
          ],
        )
      ],
    );
  }

  void initVideoInformationData() {
    if (widget.description == null) {
      description = 'no description set';
    } else {
      description = widget.description;
    }

    if (widget.language == null) {
      language = 'no language set';
    } else {
      language = widget.language;
    }

    //TODO - remove
    if (widget.url == null) {
      url =
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
    } else {
      url = widget.url;
    }

    if (widget.author == null) {
      author = 'no author set';
    } else {
      author = widget.author;
    }
  }

  /*
  * to format study programs and tags */
  String formatListData(List<String> list) {
    String data = '';
    for (String item in list) {
      data += '$item,  ';
    }
    return data;
  }

  @override
  void initState() {
    super.initState();
    initVideoInformationData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VideoWidget(
            videoPlayerController: VideoPlayerController.network(url),
            looping: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 15), //margin
                Container(
                    child: widget.avatar == null
                        ? Avatar.defaultAvatar(45.0)
                        : Avatar.setAvatar(45.0, widget.avatar)),
                SizedBox(width: 15), //margin
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(widget.videoTitle,
                      style: TextStyle(
                          fontFamily: 'BalooTammuduBold',
                          color: Colors.brown,
                          fontSize: 20.0)),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(right: 20.0),
                child: isExtended == false
                    ? FlatButton(
                        onPressed: () {
                          setState(() {
                            isExtended = true;
                          });
                        },
                        child:
                            Icon(Icons.arrow_downward, color:  Colors.blueGrey))
                    : FlatButton(
                        onPressed: () {
                          setState(() {
                            isExtended = false;
                          });
                        },
                        child:
                            Icon(Icons.arrow_upward, color:  Colors.blueGrey))),
          ],
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Divider(color: Colors.blueGrey)),
        Container(
          child: isExtended == true
              ? Column(
                  children: [videoDataExtendedSection(), commentSection()],
                )
              : null,
        ),
      ],
    );
  }
}
