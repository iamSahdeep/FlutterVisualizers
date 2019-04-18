import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_visualizers/Visualizers/BarVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/CircularBarVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/CircularLineVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/LineBarVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/LineVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/MultiWaveVisualizer.dart';
import 'package:flutter_visualizers/visualizer.dart';
import 'package:flutter_visualizers_example/methodcalls.dart';

class PlaySong extends StatefulWidget {
@override
_VisState createState() => _VisState();
}

class _VisState extends State<PlaySong> {

  int playerID;
  String selected = 'LineBarVisualizers';
  final List<String> _dropdownValues = [
    "MultiWaveVisualizer",
    "LineVisualizer",
    "LineBarVisualizer",
    "CircularLineVisualizer",
    "CircularBarVisualizer",
    "BarVisualizer"
  ];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    methodCalls.playSong();
    int sessionId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      sessionId = await methodCalls.getSessionId();
    } on Exception {
      sessionId = null;
    }

    setState(() {
      playerID = sessionId;
    });
  }

  String newValue;

  Widget dropdownWidget() {
    return DropdownButton(
      //map each value from the lIst to our dropdownMenuItem widget
      items: _dropdownValues
          .map((value) => DropdownMenuItem(
        child: Text(value),
        value: value,
      ))
          .toList(),
      onChanged: (String value) {
        newValue = value;
        setState(() {
          selected = value;
        });
      },
      //this wont make dropdown expanded and fill the horizontal space
      isExpanded: false,
      //make default value of dropdown the first value of our list
      value: newValue,
      hint: Text('choose'),

    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text(' Visulizer '),
            actions: <Widget>[
              dropdownWidget(),
            ],
          ),
          body: playerID != null ? selected == 'MultiWaveVisualizer' ? new Visualizer(
            builder: (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new MultiWaveVisualizer(
                  waveData: wave,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.blueAccent,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          ) : selected == 'LineVisualizer' ? new Visualizer(
            builder: (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new LineVisualizer(
                  waveData: wave,
                  height: MediaQuery.of(context).size.height,
                  width : MediaQuery.of(context).size.width,
                  color: Colors.blueAccent,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          ) : selected == 'LineBarVisualizer' ? new Visualizer(
            builder: (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new LineBarVisualizer(
                  waveData: wave,
                  height: MediaQuery.of(context).size.height,
                  width : MediaQuery.of(context).size.width,
                  color: Colors.blueAccent,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          ) :selected == 'CircularLineVisualizer' ? new Visualizer(
            builder: (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new CircularLineVisualizer(
                  waveData: wave,
                  height: MediaQuery.of(context).size.height,
                  width : MediaQuery.of(context).size.width,
                  color: Colors.blueAccent,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          ) : selected == 'CircularBarVisualizer' ? new Visualizer(
            builder: (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new CircularBarVisualizer(
                  waveData: wave,
                  height: MediaQuery.of(context).size.height,
                  width : MediaQuery.of(context).size.width,
                  color: Colors.blueAccent,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          ) : new Visualizer(
            builder: (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new BarVisualizer(
                  waveData: wave,
                  height: MediaQuery.of(context).size.height,
                  width : MediaQuery.of(context).size.width,
                  color: Colors.blueAccent,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          ) : Center(
            child: Text('No SessionID'),
          ),
        ));
  }

}