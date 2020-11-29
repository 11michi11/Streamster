import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/app_config.dart';
import 'package:streamster_app/common/service/rest_client.dart';
import 'package:streamster_app/my_videos/model/video_item.dart';
import 'package:streamster_app/watch_video/view/video_page.dart';

import '../search.dart';

class SearchAndroid extends StatefulWidget {
  final SearchState state;

  SearchAndroid(this.state);

  @override
  State<StatefulWidget> createState() => _SearchAndroidState();
}

class _SearchAndroidState extends State<SearchAndroid> {
  SearchStatus _status;
  final _searchTermController = TextEditingController();
  VideoItem videoItem;
  List<VideoItem> videos = new List();

  @override
  void dispose() {
    _searchTermController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state.status == SearchStatus.success) {
          // print(state.videos);
          setState(() {
            if (state.videos.length > 0) {
              videos = state.videos;
              videoItem = state.videos.first;
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('There are no videos matching search term'),
                backgroundColor: Colors.brown,
              ));
            }
          });
        }
        setState(() {
          _status = state.status;
        });
      },
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.60,
                height: 60,
                child: TextField(
                    controller: _searchTermController,
                    style: TextStyle(fontFamily: 'BalooTammudu'),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                        contentPadding: EdgeInsets.only(top: 10.0),
                        hintText: "Search")),
              ),
              SizedBox(width: 20,),
              ButtonTheme(
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.brown),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    onSearchTextChanged(_searchTermController.text);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('submit',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'BalooTammudu',
                            color: Colors.brown)),
                  ),
                ),
              ),
            ],
          ),
          _status == SearchStatus.loading
              ? progressBar()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPage(
                                videoItem.title,
                                null,
                                videoItem.authorName,
                                videoItem.description,
                                videoItem.studyPrograms,
                                videoItem.tags,
                                videoItem.language,
                                '${RestClient.videoUrl}/${videoItem.id}'),
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
                              // SizedBox(width: 10),
                              // Container(child: encodedAvatar == null ? Avatar.defaultAvatar(45.0) : Avatar.setAvatar(45.0, encodedAvatar) ),
                              // SizedBox(width: 20),
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
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    if (text.length > 2) {
      BlocProvider.of<SearchBloc>(context)
          .add(SearchBySearchTerm(searchTerm: text));
    }
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
}
