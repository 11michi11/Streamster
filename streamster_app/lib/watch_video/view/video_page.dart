
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/watch_video/view/video_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String videoTitle;
  final String avatar;
  final String author;
  final String description;
  final List<String> studyPrograms;
  final List<String> tags;
  final String language;
  final String url;

  VideoPage(this.videoTitle, this.avatar, this.author, this.description,
      this.studyPrograms, this.tags, this.language, this.url)
      : super();

  @override
  State<StatefulWidget> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  bool isExtended = false;
  String url, description, language, author;

  _VideoPageState();

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
            child: Divider(color: Colors.brown)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(Icons.star_border, color: Colors.black54, size: 35),
                Icon(Icons.star_border, color: Colors.black54, size: 35),
                Icon(Icons.star_border, color: Colors.black54, size: 35),
                Icon(Icons.star_border, color: Colors.black54, size: 35),
                Icon(Icons.star_border, color: Colors.black54, size: 35),
              ],
            ),
            Icon(Icons.add_comment_outlined, color: Colors.black54, size: 36)
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
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
                                Icon(Icons.arrow_downward, color: Colors.brown))
                        : FlatButton(
                            onPressed: () {
                              setState(() {
                                isExtended = false;
                              });
                            },
                            child:
                                Icon(Icons.arrow_upward, color: Colors.brown))),
              ],
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Divider(color: Colors.brown)),
            Container(
              child: isExtended == true
                  ? Column(
                      children: [videoDataExtendedSection(), commentSection()],
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
