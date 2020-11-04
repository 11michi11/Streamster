import 'package:flutter/material.dart';
import 'package:streamster_app/common/repository/user_repository.dart';
import 'package:streamster_app/logout/logout_view_android.dart';
import 'package:streamster_app/watch_video/view/video_page.dart';

class HomeFormAndroid extends StatefulWidget {
  final UserRepository userRepository;

  const HomeFormAndroid({Key key, this.userRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeFormAndroidState(userRepository);
}

class _HomeFormAndroidState extends State<HomeFormAndroid> {
  final UserRepository userRepository;

  _HomeFormAndroidState(this.userRepository);

  Widget defaultImage() {
    return Container(
        width: 90.0,
        height: 90.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("images/person_grey_icon.png"))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar:
            AppBar(backgroundColor: Colors.brown, title: Text('Streamster')),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultImage(),
                      Text('Matej Michalek',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'BalooTammudu',
                              color: Colors.white)),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.brown,
                      border: Border(bottom: BorderSide(color: Colors.brown)))),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.file_upload, color: Colors.brown),
                    SizedBox(width: 15),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('Upload Video',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'BalooTammudu',
                              color: Colors.brown)),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/uploadVideo');
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.camera_enhance_rounded, color: Colors.brown),
                    SizedBox(width: 15),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('My Videos',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'BalooTammudu',
                              color: Colors.brown)),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/myVideos');
                },
              ),
              LogoutButton()
            ],
          ),
        ),
        body: VideoPage(null,null,null,null,null,null));
  }
}
