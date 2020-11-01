import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_bloc.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_event.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_state.dart';
import 'package:streamster_app/my_videos/model/video_item.dart';
import 'package:streamster_app/my_videos/repository/my_videos_repository.dart';
import 'package:streamster_app/watch_video/view/video_page.dart';

class MyVideosAndroid extends StatefulWidget {
  final MyVideosState state;

  MyVideosAndroid(this.state);

  @override
  State<StatefulWidget> createState() => _MyVideosAndroidState();
}

class _MyVideosAndroidState extends State<MyVideosAndroid> {

  VideoItem videoItem;
  List<VideoItem> videos = new List();

  @override
  void initState() {
    BlocProvider.of<MyVideosBloc>(context).add(GetAllVideos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyVideosBloc, MyVideosState>(
      listener: (context, state) {
        if (state.status == MyVideosStatus.success) {
          print(state.videos);
          setState(() {
            videos = state.videos;
            videoItem = state.videos.first;
          });
        } else if(state.status == MyVideosStatus.inProgress) {
          print('loading');
        }
      },
      child: Column(
        children: [
          FlatButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPage(videoItem.authorName,videoItem.description,videoItem.studyPrograms,
                videoItem.tags, videoItem.language, 'https://apigateway-ayoqp7z2fq-lz.a.run.app/video-service/streaming/5f8469bf2dc3a978cd007c68'),
              ),
            );
          },
            child: Text('test'),),
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 150.0,
                  child: Card(
                    child: ListTile(
                      title: Text(' ${videos[index].title}',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'BalooTammudu',
                              color: Colors.brown))
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
