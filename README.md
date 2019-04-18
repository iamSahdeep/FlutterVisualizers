# flutter_visualizers [![Pub](https://img.shields.io/pub/v/flutter_visualizers.svg?style=flat-square)](https://pub.dartlang.org/packages/flutter_visualizers)

A Flutter plugin to Visualize the audio being played (only android).

## Usage
* Add this to your pubspec.yaml
  ```
  dependencies:
  flutter_visualizers: ^0.0.1
  
  ```
* Get package from Pub:

  ```
  flutter packages get
  ```
* Import it in your file

  ```
  import 'package:flutter_visualizers/flutter_visualizers.dart';
  ```
  
## Example
  * Firstly, get a audioSessionID from your native android Mediaplayer.
    ```
    player.getAudioSessionId()
    ```
  * Simply Include this code in ``` body ```
    ```
    new Visualizer(
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
          )
    ```
    Here playerId is the AudioSessionId which id needed to initialize the Visualizer. (Required Audio Recording Permission in Android)

    See the Complete [Example](https://github.com/iamSahdeep/FlutterVisualizers/tree/master/example)
### Sample 

![Video](https://github.com/iamSahdeep/FlutterVisualizers/blob/master/assets/sample.gif)

- Apk
 [Download](https://github.com/iamSahdeep/FlutterVisualizers/blob/master/assets/app-release.apk)
 
### Credits
   - [GautamChibde](https://github.com/GautamChibde) for awesome [Visualizers](https://github.com/GautamChibde/android-audio-visualizer) in Android from which I made this.
   - [Matt Carroll](https://github.com/matthew-carroll) for this [UI](https://github.com/matthew-carroll/flutter_ui_challenge_music_player/blob/recording/lib/main.dart)

## License

    Copyright [2018] [Sahdeep Singh]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    
### Getting Started with Flutter

This project is a starting point for a Flutter
[plug-in package](https://flutter.io/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
