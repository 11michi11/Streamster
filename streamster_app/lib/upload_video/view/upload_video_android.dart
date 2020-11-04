import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/register/model/avatar_picker.dart';
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
  final _studyProgramController = TextEditingController();
  final _languageController = TextEditingController();
  final _thumbnailController = TextEditingController();

  Video video;
  List<String> tags = new List();
  List<String> studyPrograms = new List();

  _UploadVideoAndroidState() {
    /*
    * TODO - test data delete
    * */
    tags.add("programming");
    tags.add("java");
    tags.add("object oriented programming");
    studyPrograms.add("software engineering");
    studyPrograms.add("global business engineering");
  }

  onUploadButtonPressed(String title, String description, List<String> tags) {
    if (video != null) {
      BlocProvider.of<UploadVideoBloc>(context).add(UploadVideo(
          title, description, tags, video.fileName, video.videoData));
    }
  }

  onSelectVideoFile() async {
    video = await VideoPicker.pickVideoAndroid();
    setState(() {
      _fileNameController.text = video.fileName;
    });
  }

  /*
  * TODO - add avatar to request
  * */
  onSelectThumbnail() async {
    var avatar = await AvatarPicker.pickImageAndroid();
    setState(() {
      _thumbnailController.text = "image added";
    });
  }

  onAddItemClicked(controller, list) {
    var item = controller.text;
    setState(() {
      list.insert(0,item);
    });
  }

  onDeleteItemClicked(index, list) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('${list[index]} deleted')));
    setState(() {
      list.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Expanded(
        child: ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          itemBuilder: (ctx, int) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20), //margin
                titleField(),
                tagField(),
                scrollableViewList(tags),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  alignment: Alignment(-0.7,0),
                  child: Text("Study Programs",
                      style: TextStyle(
                          fontFamily: 'BalooTammudu',
                          color: Colors.brown,
                          fontSize: 20)),
                ),
                studyProgramField(),
                scrollableViewList(studyPrograms),
                descriptionField(),
                languageField(),
                selectFileField(),
                selectThumbnailField(),
                Container(
                    margin: EdgeInsets.only(top: 50, bottom: 50),
                    child: UploadButton(widget.state, context, _tagsController,
                        _titleController, _descriptionController, video))
              ],
            );
          },
        ),
      ),
    );
  }

  Widget titleField() {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Text("Title",
              style: TextStyle(
                  fontFamily: 'BalooTammudu',
                  color: Colors.brown,
                  fontSize: 20)),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.60,
          height: 60,
          child: TextField(
              controller: _titleController,
              style: TextStyle(fontFamily: 'BalooTammudu'),
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  hintText: "Enter title")),
        ),
      ],
    );
  }

  Widget tagField() {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Text("Tags",
              style: TextStyle(
                  fontFamily: 'BalooTammudu',
                  color: Colors.brown,
                  fontSize: 20)),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.40,
          height: 60,
          child: TextField(
              controller: _tagsController,
              style: TextStyle(fontFamily: 'BalooTammudu'),
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  hintText: "Enter tag")),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        ButtonTheme(
          minWidth: 65,
          height: 30,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.black54),
            ),
            color: Colors.white,
            onPressed: () {
              onAddItemClicked(_tagsController, tags);
              _tagsController.text = '';
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('add',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'BalooTammudu',
                      color: Colors.black54)),
            ),
          ),
        )
      ],
    );
  }

  Widget studyProgramField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.60,
          height: 60,
          child: TextField(
              controller: _studyProgramController,
              style: TextStyle(fontFamily: 'BalooTammudu'),
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  hintText: 'enter study program')),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        ButtonTheme(
          minWidth: 65,
          height: 30,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.black54),
            ),
            color: Colors.white,
            onPressed: () {
              onAddItemClicked(_studyProgramController, studyPrograms);
              _studyProgramController.text = '';
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('add',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'BalooTammudu',
                      color: Colors.black54)),
            ),
          ),
        )
      ],
    );
  }

  Widget descriptionField() {
    return Column(
      children: [
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
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
              elevation: 3,
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
    );
  }

  Widget selectFileField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
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
                  side: BorderSide(color: Colors.black54),
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.white,
              onPressed: () {
                print(widget.state.status.toString());
                if (widget.state.status != UploadVideoStatus.uploading) {
                  onSelectVideoFile();
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
    );
  }

  Widget languageField() {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Text("Language",
              style: TextStyle(
                  fontFamily: 'BalooTammudu',
                  color: Colors.brown,
                  fontSize: 20)),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
          height: 60,
          child: TextField(
              controller: _languageController,
              style: TextStyle(fontFamily: 'BalooTammudu'),
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  hintText: "Enter language")),
        ),
      ],
    );
  }

  Widget selectThumbnailField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
            Text('Select thumbnail',
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
                  side: BorderSide(color: Colors.black54),
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.white,
              onPressed: () {
                onSelectThumbnail();
              },
              child: Icon(Icons.add_photo_alternate_outlined, color: Colors.black54)),
        ),
        SizedBox(
          width: 300,
          height: 50,
          child: TextField(
              readOnly: true,
              controller: _thumbnailController,
              style: TextStyle(fontFamily: 'BalooTammudu'),
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'BalooTammudu'),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  hintText: 'File name')),
        ),
      ],
    );
  }

  Widget scrollableViewList(list) {
    return Opacity(
      opacity: 0.4,
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.black26,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black26)
        ),
       // color: Colors.black26,
        width: MediaQuery.of(context).size.width * 0.85,
        height: 50,
        child: Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (BuildContext context, index) =>
                  GestureDetector(
                    onDoubleTap: () => {
                      onDeleteItemClicked(index,list)
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 30),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                          child: Text(list[index],
                              style: TextStyle(
                                  fontFamily: 'BalooTammudu',
                                  color: Colors.black,
                                  fontSize: 20)),
                        )),
                  )),
        ),
      ),
    );
  }
}
