import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/upload_video/model/video.dart';
import 'package:streamster_app/upload_video/model/video_picker.dart';

import '../upload_video.dart';
import 'upload_button.dart';

class UploadVideoAndroid extends StatefulWidget {

  final UploadVideoState state;
  UploadVideoAndroid(this.state);

  @override
  State<StatefulWidget> createState() => _UploadVideoAndroidState();
}

class _UploadVideoAndroidState extends State<UploadVideoAndroid> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();
  final _fileNameController = TextEditingController();
  Video video;

  onUploadButtonPressed(String title, String description, List<String> tags) {

    if(video != null) {
      BlocProvider.of<UploadVideoBloc>(context).add(
          UploadVideo(title, description, tags, video.fileName, video.videoData));
    }
  }

  onSelectFile() async {
    print("select file android");
    video = await VideoPicker.pickVideoAndroid();
    setState(() {
      _fileNameController.text = video.fileName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Upload Video',
                      style: TextStyle(
                          fontFamily: 'BalooTammudu',
                          color: Colors.brown,
                          fontSize: 30)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Title',
                    style: TextStyle(
                        fontFamily: 'BalooTammudu',
                        color: Colors.brown,
                        fontSize: 20)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: 60,
                  child: TextField(
                      controller: _titleController,
                      style: TextStyle(fontFamily: 'BalooTammudu'),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                          contentPadding: EdgeInsets.only(top: 10.0),
                          hintText: 'Enter title')),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Tags',
                    style: TextStyle(
                        fontFamily: 'BalooTammudu',
                        color: Colors.brown,
                        fontSize: 20)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: 60,
                  child: TextField(
                      controller: _tagsController,
                      style: TextStyle(fontFamily: 'BalooTammudu'),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                          contentPadding: EdgeInsets.only(top: 10.0),
                          hintText: 'Enter tags')),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 40),
                    Text('Description',
                        style: TextStyle(
                            fontFamily: 'BalooTammudu',
                            color: Colors.brown,
                            fontSize: 20)),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: 160,
                  child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          maxLines: 10,
                          controller: _descriptionController,
                          style: TextStyle(fontFamily: 'BalooTammudu'),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                              contentPadding: EdgeInsets.only(top: 10.0),
                              hintText: 'Enter description'),
                        ),
                      )),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 40),
                    Text('Select file',
                        style: TextStyle(
                            fontFamily: 'BalooTammudu',
                            color: Colors.brown,
                            fontSize: 20)),
                  ],
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.80,
                  height: 50,
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.brown),
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Colors.white,
                      onPressed: () {
                        print(widget.state.status.toString());
                        if (widget.state.status !=
                            UploadVideoStatus.uploading) {
                          onSelectFile();
                        }
                      },
                      child: Icon(Icons.file_upload, color: Colors.black54)),
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                      readOnly: true,
                      controller: _fileNameController,
                      style: TextStyle(fontFamily: 'BalooTammudu'),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                          contentPadding: EdgeInsets.only(top: 10.0),
                          hintText: 'File name')),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 50),
                child: UploadButton(widget.state, context, _tagsController,
                    _titleController, _descriptionController, video))
          ],
        ),
      ),
    );
  }
}
