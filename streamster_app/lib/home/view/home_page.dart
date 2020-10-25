
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  onUploadVideoPressed() {
    Navigator.of(context).pushNamed('/uploadVideo');
  }

  onLogoutPressed() {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  Widget defaultImage() {
    return Container(
        width: 90.0,
        height: 90.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://scontent-cph2-1.xx.fbcdn.net/v/t31.0-8/18358881_1293777014069016_6493560286323388419_o.jpg?_nc_cat=104&_nc_sid=09cbfe&_nc_ohc=ObxWnFMAMGgAX9R_SfZ&_nc_ht=scontent-cph2-1.xx&oh=0f5fa0c0ea02b3df77eecd4fc8ab548e&oe=5FAB318A"))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.brown, title: Text('Streamster')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultImage(),
                  Text('Matej Michalek', style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'BalooTammudu',
                      color: Colors.white))
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.brown,
                border: Border(
                  bottom: BorderSide(color: Colors.brown)
                ))
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.file_upload, color: Colors.brown),
                  SizedBox(width: 15),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('Upload Video',style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'BalooTammudu',
                        color: Colors.brown)),
                  ),
                ],
              ),
              onTap: () {
                onUploadVideoPressed();
              },
            ),
            ListTile(
              title: Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text('Log out',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'BalooTammudu',
                        color: Colors.brown)),
              ),
              onTap: () {
                onLogoutPressed();
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(),
      )
    );
  }
}