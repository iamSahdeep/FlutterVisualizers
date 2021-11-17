import 'package:flutter/widgets.dart';
import 'package:flutter_visualizers/callbacks.dart';
import 'package:flutter_visualizers/flutter_visualizers.dart';

class Visualizer extends StatefulWidget {

  final Function(BuildContext context, List<int> fft)? builder;
  int? id;
  Visualizer({
    this.builder, this.id
  });

  @override
  _VisualizerState createState() => new _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {

  late AudioVisualizer visualizer;
  List<int> fft = const [];
  @override
  void initState() {
    super.initState();
    visualizer = FlutterVisualizers.audioVisualizer()
      ..activate(widget.id)
      ..addListener(
          waveformCallback: (List<int> samples) {
            setState(() => fft = samples);
          }
      );
  }

  @override
  void dispose() {
    visualizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder!(context, fft);
  }
}
