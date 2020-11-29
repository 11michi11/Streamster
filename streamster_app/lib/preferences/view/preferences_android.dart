import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../preferences.dart';

class PreferencesAndroid extends StatefulWidget {
  final PreferencesState state;

  PreferencesAndroid(this.state);

  @override
  State<StatefulWidget> createState() => _PreferencesAndroidState();
}

class _PreferencesAndroidState extends State<PreferencesAndroid> {
  final _tagsController = TextEditingController();
  final _studyProgramsController = TextEditingController();

  List<String> tags = new List();
  List<String> studyPrograms = new List();

  double _currentMinSliderValue = 0;
  double _currentMaxSliderValue = 0;

  onAddItemClicked(controller, list) {
    var item = controller.text;
    setState(() {
      list.insert(0, item);
    });
  }

  onDeleteItemClicked(index, list) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('${list[index]} deleted')));
    setState(() {
      list.removeAt(index);
    });
  }

  Widget scrollableViewList(list) {
    return Opacity(
      opacity: 0.4,
      child: Container(
        decoration: BoxDecoration(
            //color: Colors.black26,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black26)),
        // color: Colors.black26,
        width: MediaQuery.of(context).size.width * 0.85,
        height: 50,
        child: Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (BuildContext context, index) => GestureDetector(
                    onDoubleTap: () => {onDeleteItemClicked(index, list)},
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

  Widget tagField() {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Text("Tags",
              style: TextStyle(
                  fontFamily: 'BalooTammuduBold',
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
              controller: _studyProgramsController,
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
              onAddItemClicked(_studyProgramsController, studyPrograms);
              _studyProgramsController.text = '';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Text(
              "Set your preferences to help us create better recommendation for you",
              style: TextStyle(
                  fontFamily: 'BalooTammudu',
                  color: Colors.brown,
                  fontSize: 20)),
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.85,
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: Divider()),
        tagField(),
        scrollableViewList(tags),
        Container(
          margin: EdgeInsets.only(top: 15),
          alignment: Alignment(-0.7, 0),
          child: Text("Study Programs",
              style: TextStyle(
                  fontFamily: 'BalooTammuduBold',
                  color: Colors.brown,
                  fontSize: 20)),
        ),
        studyProgramField(),
        scrollableViewList(studyPrograms),
        Container(
          margin: EdgeInsets.only(top: 15),
          alignment: Alignment(-0.75, 0),
          child: Text("Minimal length",
              style: TextStyle(
                  fontFamily: 'BalooTammuduBold',
                  color: Colors.brown,
                  fontSize: 20)),
        ),
        Slider(
            value: _currentMinSliderValue,
            min: 0,
            max: 60,
            divisions: 6,
            label:'${_currentMinSliderValue.round().toString()} minutes',
            onChanged: (double value) {
              setState(() {
                _currentMinSliderValue = value;
              });
            }),
        Container(
          margin: EdgeInsets.only(top: 15),
          alignment: Alignment(-0.75, 0),
          child: Text("Maximal length",
              style: TextStyle(
                  fontFamily: 'BalooTammuduBold',
                  color: Colors.brown,
                  fontSize: 20)),
        ),
        Slider(
            value: _currentMaxSliderValue,
            min: 0,
            max: 60,
            divisions: 6,
            label:sliderLabel(_currentMaxSliderValue.round()),
            onChanged: (double value) {
              setState(() {
                _currentMaxSliderValue = value;
              });
            })
      ],
    );
  }

  String sliderLabel(value) {
    if(value < 10) {
      return '5 minutes';
    } else {
      return '$value minutes';
    }
  }

}
