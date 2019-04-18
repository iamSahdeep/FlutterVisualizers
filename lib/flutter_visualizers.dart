import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_visualizers/callbacks.dart';

class FlutterVisualizers {
  static const MethodChannel _channel =
      const MethodChannel('fluttery_audio_visualizer');

  static AudioVisualizer audioVisualizer() {
    return new AudioVisualizer(
      channel: _channel,
    );
  }
}
