
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/common/repository/user_repository.dart';
import 'package:streamster_app/logout/view/logout_view.dart';
import 'package:streamster_app/search/search.dart';

class HomeFormAndroid extends StatefulWidget {

  final UserRepository userRepository;
  final SearchRepository searchRepository;

  const HomeFormAndroid({this.userRepository, this.searchRepository});

  @override
  State<StatefulWidget> createState() =>
      _HomeFormAndroidState(userRepository, searchRepository);
}

class _HomeFormAndroidState extends State<HomeFormAndroid> {
  final UserRepository userRepository;
  final SearchRepository searchRepository;
  String avatarEncoded;
  String userName = '';

  /*
   * TEST DATA
   * */
  List<String> studyPrograms = new List();

  _HomeFormAndroidState(this.userRepository, this.searchRepository) {
    studyPrograms.add('Software engineering');
    studyPrograms.add('GBE');
  }

  void getUserData() async {
    var user = await userRepository.getUserDetails();
    print(user.toString());
    setState(() {
      avatarEncoded = user.avatar;
      userName = '${user.firstName} ${user.lastName}';
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
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
                      Container(child: avatarEncoded == null ? Avatar.defaultAvatar(90.0) : Avatar.setAvatar(90.0, avatarEncoded)),
                      Text(userName,
                          style: TextStyle(
                              fontSize: 20,
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
                    Icon(Icons.home, color: Colors.brown),
                    SizedBox(width: 15),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('Home',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'BalooTammudu',
                              color: Colors.brown)),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/home');
                },
              ),
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
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.room_preferences, color: Colors.brown),
                    SizedBox(width: 15),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('Preferences',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'BalooTammudu',
                              color: Colors.brown)),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/preferences');
                },
              ),
              LogoutButtonWidget()
            ],
          ),
        ),
      //TODO - design home page
      body: BlocProvider(
        create: (context) {
          return SearchBloc(searchRepository: searchRepository);
        },
        child: SearchForm(),
      ),
    );
  }
}
