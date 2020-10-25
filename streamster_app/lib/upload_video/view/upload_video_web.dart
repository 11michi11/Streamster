import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/upload_video/model/video.dart';
import 'package:streamster_app/upload_video/model/video_picker.dart';

import '../upload_video.dart';
import 'upload_button.dart';

class UploadVideoWeb extends StatefulWidget {

  final UploadVideoState state;
  UploadVideoWeb(this.state);

  @override
  State<StatefulWidget> createState()  => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideoWeb> {
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
    video = await VideoPicker.pickVideoWeb();
    setState(() {
      _fileNameController.text = video.fileName;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.50,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Card(
          child:
//          state.status == UploadVideoStatus.uploading ? SizedBox(width: 35, height: 35,child: CircularProgressIndicator()) :
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 25, bottom: 20),
                        child: Icon(
                          Icons.video_call,
                          color: Colors.brown,
                          size: 50,
                        )),
                    Text('Upload Video Page',
                        style: TextStyle(
                            fontFamily: 'BalooTammuduBold',
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
                          fontFamily: 'BalooTammuduBold',
                          color: Colors.brown,
                          fontSize: 20)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
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
                          fontFamily: 'BalooTammuduBold',
                          color: Colors.brown,
                          fontSize: 20)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Description',
                      style: TextStyle(
                          fontFamily: 'BalooTammuduBold',
                          color: Colors.brown,
                          fontSize: 20)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
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
                                hintStyle:
                                TextStyle(fontFamily: 'BalooTammudu'),
                                contentPadding: EdgeInsets.only(top: 10.0),
                                hintText: 'Enter description'),
                          ),
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Select file',
                      style: TextStyle(
                          fontFamily: 'BalooTammuduBold',
                          color: Colors.brown,
                          fontSize: 20)),
                  ButtonTheme(
                    minWidth: 150,
                    height: 50,
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.brown),
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.white,
                        onPressed: () {
                          if (widget.state.status != UploadVideoStatus.uploading) {
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
              UploadButton(widget.state, context, _tagsController, _titleController, _descriptionController, video)
            ],
          ),
        ),
      ),
    );
  }

}