
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/my_videos/model/video_item.dart';
import 'package:streamster_app/recommendations/bloc/recommendations_bloc.dart';
import 'package:streamster_app/recommendations/bloc/recommendations_event.dart';
import 'package:streamster_app/recommendations/bloc/recommendations_state.dart';
import 'package:streamster_app/recommendations/repository/recommendations_repository.dart';
import 'package:streamster_app/watch_video/view/video_page.dart';

class RecommendationsAndroid extends StatefulWidget {
  final RecommendationsState state;

  RecommendationsAndroid(this.state);
  @override
  State<StatefulWidget> createState() => _RecommendationsAndroidState();
}

class _RecommendationsAndroidState extends State<RecommendationsAndroid> {
  RecommendationsStatus _status;
  List<VideoItem> videos = new List();
  List<User> users = new List();

  @override
  void initState() {
    BlocProvider.of<RecommendationsBloc>(context).add(GetRecommendations());
    _status = RecommendationsStatus.loading;
    super.initState();

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
    return BlocListener<RecommendationsBloc, RecommendationsState>(
      listener: (context, state) {
        setState(() {
          _status = state.status;
        });
        print('recommendations status: ${state.status}');
        if (state.status == RecommendationsStatus.success) {
          print(state.videos.length);
          setState(() {
            if (state.videos.length > 0) {
              videos = state.videos;
              users = state.users;
            }
          });
        }
        else if(state.status == RecommendationsStatus.error) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('No recommendations found'),
            backgroundColor: Colors.blueGrey,
          ));
        }
        setState(() {
          _status = state.status;
        });
      },
      child: _status == RecommendationsStatus.loading
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
                    users[index].avatar,
                    videos[index].authorName,
                    videos[index].description,
                    videos[index].studyPrograms,
                    videos[index].tags,
                    videos[index].language,
                    '${RestClient.videoUrl}/${videos[index].id}',
                    videos[index].id,
                    videos[index].likedBy,
                    videos[index].dislikedBy,
                  ),
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
                    Container(child: users[index].avatar == null ? Avatar.defaultAvatar(45.0) : Avatar.setAvatar(45.0, users[index].avatar) ),
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