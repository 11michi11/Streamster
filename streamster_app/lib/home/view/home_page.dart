
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  onUploadVideoPressed() {
    Navigator.of(context).pushNamed('/uploadVideo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.brown, title: Text('Streamster')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 50, right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(children: [
              FloatingActionButton(
                backgroundColor: Colors.brown,
                child: Icon(Icons.add),
                onPressed: () {
                  onUploadVideoPressed();
                },),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text('upload video',
                    style: TextStyle(
                    fontFamily: 'BalooTammuduBold',
                    color: Colors.brown,
                    fontSize: 15)),
              )
            ],),
          ],
        ),
      )
    );
  }

}