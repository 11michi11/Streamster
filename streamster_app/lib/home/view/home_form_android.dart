import 'package:flutter/material.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/common/repository/user_repository.dart';
import 'package:streamster_app/logout/view/logout_view.dart';
import 'package:streamster_app/recommendations/recommendations.dart';
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
  RecommendationsRepository recommendationsRepository = new RecommendationsRepository();
  String avatarEncoded;
  String userName = '';
  User user;

  _HomeFormAndroidState(this.userRepository, this.searchRepository);

  void getUserData() async {
    user = await userRepository.getUserDetails();
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
              Container(
                child: user.systemRole == SystemRole.student ? null : ListTile(
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ButtonTheme(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.brown),
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamed('/search');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: Icon(Icons.search, color: Colors.brown),
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text('search',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'BalooTammudu',
                              color: Colors.brown)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //RECOMMENDATIONS
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text('recommendations',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'BalooTammuduBold',
                    color: Colors.brown)),
          ),
          Expanded(
            child: RecommendationsPage(recommendationsRepository: recommendationsRepository, userRepository: userRepository,)
          )
        ],
      ),
    );
  }
}
