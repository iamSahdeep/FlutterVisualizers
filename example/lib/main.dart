import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_visualizers_example/Ui.dart';
import 'package:flutter_visualizers_example/methodcalls.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(' Example'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              splashColor: Colors.pinkAccent,
              color: Colors.black,
              child: new Text(
                "Play Song",
                style: new TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlaySong()),
                );
              },
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
          ],
        ),
      ) ,
    );
  }
}

/*
* new Visualizer(
            builder: (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new CircularLineVisualizer(
                  waveData: wave,
                  height: MediaQuery.of(context).size.height,
                  width : MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          ),
          */

