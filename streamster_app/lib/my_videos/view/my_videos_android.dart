import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/app_config.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_bloc.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_event.dart';
import 'package:streamster_app/my_videos/bloc/my_videos_state.dart';
import 'package:streamster_app/my_videos/model/video_item.dart';
import 'package:streamster_app/my_videos/repository/my_videos_repository.dart';
import 'package:streamster_app/watch_video/watch_video.dart';
import 'dart:convert';
import 'dart:typed_data';

import '../../main.dart';

class MyVideosAndroid extends StatefulWidget {
  final MyVideosState state;

  MyVideosAndroid(this.state);
  @override
  State<StatefulWidget> createState() => _MyVideosAndroidState();
}

class _MyVideosAndroidState extends State<MyVideosAndroid> {
  MyVideosStatus _status;
  VideoItem videoItem;
  List<VideoItem> videos = new List();
  String encodedAvatar;

  @override
  void initState() {
    BlocProvider.of<MyVideosBloc>(context).add(GetAllVideos());
    super.initState();
    _status = MyVideosStatus.inProgress;
  }

  Widget setThumbnail(encodedImage) {
    Uint8List bytes = base64Decode(encodedImage);
    return Image.memory(bytes);
  }

  Widget progressBar() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyVideosBloc, MyVideosState>(
      listener: (context, state) {
        if (state.status == MyVideosStatus.success) {
          print(state.videos.length);
          setState(() {
            if (state.videos.length > 0) {
              videos = state.videos;
              //videoItem = state.videos.first;
              encodedAvatar = state.user.avatar;
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('You have no videos'),
                backgroundColor: Colors.brown,
              ));
            }
          });
        }
        setState(() {
          _status = state.status;
        });
      },
      child: _status == MyVideosStatus.inProgress
          ? progressBar()
          : ListView.builder(
              itemCount: videos.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPage(
                            videos[index].title,
                            encodedAvatar,
                            videos[index].authorName,
                            videos[index].description,
                            videos[index].studyPrograms,
                            videos[index].tags,
                            videos[index].language,
                            '${RestClient.videoUrl}/${videos[index].id}',
                            videos[index].id),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        child: videos[index].thumbnail == null
                            ? Image.asset('images/brnk_thumbnail.PNG')
                            : setThumbnail(videos[index].thumbnail),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Container(child: encodedAvatar == null ? Avatar.defaultAvatar(45.0) : Avatar.setAvatar(45.0, encodedAvatar) ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${videos[index].title}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold)),
                              Text('${videos[index].authorName}',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.brown)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
