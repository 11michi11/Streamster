import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streamster_app/watch_video/view/video_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {

  final String author;
  final String description;
  final List<String> studyPrograms;
  final List<String> tags;
  final String language;
  final String url;

  VideoPage(this.author, this.description, this.studyPrograms, this.tags, this.language, this.url) : super();

  @override
  State<StatefulWidget> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  
  bool isExtended = false;
  String url;
  
  Widget defaultImage() {
    return Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://scontent-cph2-1.xx.fbcdn.net/v/t31.0-8/18358881_1293777014069016_6493560286323388419_o.jpg?_nc_cat=104&_nc_sid=09cbfe&_nc_ohc=ObxWnFMAMGgAX9R_SfZ&_nc_ht=scontent-cph2-1.xx&oh=0f5fa0c0ea02b3df77eecd4fc8ab548e&oe=5FAB318A"))));
  }

  Widget videoItemExtended() {
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
              Text("MATEJ MICHALEK",
                  style: TextStyle(
                      fontFamily: 'BalooTammudu',
                      color: Colors.black54,
                      fontSize: 17)),
              Text("description",
                  style: TextStyle(
                      fontFamily: 'BalooTammuduBold',
                      color: Colors.brown,
                      fontSize: 15)),
              Text(
                  "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
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
              Text("Software engineering, Global Business Engineering",
                  style: TextStyle(
                      fontFamily: 'BalooTammudu',
                      color: Colors.black54,
                      fontSize: 15)),
              Text("tags",
                  style: TextStyle(
                      fontFamily: 'BalooTammuduBold',
                      color: Colors.brown,
                      fontSize: 15)),
              Text("nature, programming, marketing",
                  style: TextStyle(
                      fontFamily: 'BalooTammudu',
                      color: Colors.black54,
                      fontSize: 15)),
              Text("language",
                  style: TextStyle(
                      fontFamily: 'BalooTammuduBold',
                      color: Colors.brown,
                      fontSize: 15)),
              Text("english",
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
    return Column(children: [
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
    ],);
  }

  @override
  void initState() {
    if(widget.url == null) {
      url = 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
    } else {
      url = widget.url;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            VideoWidget(
              videoPlayerController: VideoPlayerController.network(
                  //'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
                  url,
                  formatHint: VideoFormat.other),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 15),//margin
                    defaultImage(),
                    SizedBox(width: 15), //margin
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Butterfly Valley",
                          style: TextStyle(
                              fontFamily: 'BalooTammuduBold',
                              color: Colors.brown,
                              fontSize: 20.0)),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(right: 20.0),
                    child: isExtended == false ? FlatButton(onPressed: () { setState(() {
                      isExtended = true;
                    });},child: Icon(Icons.arrow_downward, color: Colors.brown)) :
                    FlatButton(onPressed: () { setState(() {
                      isExtended = false;
                    });}, child: Icon(Icons.arrow_upward, color: Colors.brown))),
              ],
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Divider(color: Colors.brown)),
            Container(
              child: isExtended == true ? Column(
                children: [
                  videoItemExtended(),
                  commentSection()
                ],
              ) : null,
            ),
          ],
        ),
      ),
    );
  }
}
