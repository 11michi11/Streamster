import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/common/repository/user_repository.dart';

import '../preferences.dart';

class PreferencesAndroid extends StatefulWidget {
  final PreferencesState state;
  final UserRepository userRepository;

  PreferencesAndroid(this.state, this.userRepository);

  @override
  State<StatefulWidget> createState() =>
      _PreferencesAndroidState(userRepository);
}

class _PreferencesAndroidState extends State<PreferencesAndroid> {
  final UserRepository userRepository;
  final _tagsController = TextEditingController();

  List<String> tags = new List();
  List<String> studyPrograms = new List();

  double _currentMinSliderValue = 0;
  double _currentMaxSliderValue = 0;
  String studyProgramsDropdownValue;

  _PreferencesAndroidState(this.userRepository);

  @override
  void initState() {
    var preferences = userRepository.user.preferences;
    if (preferences != null) {
      tags = preferences.tags;
      studyPrograms = preferences.studyPrograms;
      _currentMinSliderValue = preferences.minLength / 60.0;
      _currentMaxSliderValue = preferences.maxLength / 60.0;
    }
    super.initState();
  }

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
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black26)),
        width: MediaQuery.of(context).size.width * 0.85,
        height: 50,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, index) => GestureDetector(
                        onDoubleTap: () => {onDeleteItemClicked(index, list)},
                        child: Container(
                            margin: EdgeInsets.only(right: 30),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 10.0),
                              child: Text(list[index],
                                  style: TextStyle(
                                      fontFamily: 'BalooTammudu',
                                      color: Colors.black,
                                      fontSize: 20)),
                            )),
                      )),
            ),
          ],
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
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black26)),
      child: DropdownButton<String>(
        value: studyProgramsDropdownValue,
        isExpanded: true,
        onChanged: (String newValue) {
          setState(() {
            studyProgramsDropdownValue = newValue;
            studyPrograms.insert(0, newValue);
          });
        },
        items: <String>[
          StudyPrograms.GBE.name,
          StudyPrograms.ICT.name,
          StudyPrograms.ME.name,
          StudyPrograms.CE.name,
          StudyPrograms.MM.name,
          StudyPrograms.VCE.name
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(child: Text(value)),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.85,
            child: Text(
                "Set your preferences to help us create better recommendation for you",
                style: TextStyle(
                    fontFamily: 'BalooTammudu',
                    color: Colors.brown,
                    fontSize: 20)),
          ),
          Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.85,
              margin: EdgeInsets.only(bottom: 10, top: 10),
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
              label: '${_currentMinSliderValue.round().toString()} minutes',
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
              label: sliderLabel(_currentMaxSliderValue.round()),
              onChanged: (double value) {
                setState(() {
                  _currentMaxSliderValue = value;
                });
              }),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: ButtonTheme(
              minWidth: 200,
              height: 60,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.brown),
                ),
                color: Colors.white,
                onPressed: () {
                  savePreferences();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text('save',
                      style: TextStyle(
                          fontSize: 21,
                          fontFamily: 'BalooTammudu',
                          color: Colors.brown)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String sliderLabel(value) {
    if (value < 10) {
      return '5 minutes';
    } else {
      return '$value minutes';
    }
  }

  void savePreferences() {
    if (_currentMinSliderValue >= _currentMaxSliderValue) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Maximum length must be bigger then minimum'),
        backgroundColor: Colors.red,
      ));
    }
    var programs = setStudyPrograms(studyPrograms);
    print(programs);

    BlocProvider.of<PreferencesBloc>(context)
          .add(SavePreferences(
          tags, programs, (_currentMinSliderValue * 60).toInt(),
          (_currentMaxSliderValue * 60).toInt()));
    }

    List<String> setStudyPrograms(studyPrograms) {
        List<String> programs = new List();

        for(var studyProgram in studyPrograms) {
          var program = convertStudyProgram(studyProgram);
          programs.add(program);
        }

        return programs;
    }

    String convertStudyProgram(program) {
      switch(program) {
        case 'Global Business Engineering':
          return StudyPrograms.GBE.program;
        case 'Software Engineering':
          return StudyPrograms.ICT.program;
        case 'Mechanical Engineering':
          return StudyPrograms.ME.program;
        case 'Civil Engineering':
          return StudyPrograms.CE.program;
        case 'Marketing Management':
          return StudyPrograms.MM.program;
        case 'Value Chain':
          return StudyPrograms.VCE.program;
        default:
          return null;
      }
    }
  }


