import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math_64.dart';

class CircularLineVisualizer extends CustomPainter {

  final List<int> waveData;
  Float32List points;
  final double height;
  final double width;
  final Color color;
  final Paint wavePaint;
  final int density;
  final double strokeWidth;
  double radius = -1;

  CircularLineVisualizer({
    @required this.waveData,
    @required this.height,
    @required this.width,
    @required this.color,
    this.density = 100,
    this.strokeWidth = 0.005
  }) : wavePaint = new Paint()
    ..color = color.withOpacity(1.0)
    ..style = PaintingStyle.fill,
        assert(waveData != null),
        assert(height!= null),
        assert(width != null),
        assert(color != null);

  @override
  void paint(Canvas canvas, Size size) {


    if (waveData != null) {
      if (points == null || points.length < waveData.length * 4) {
        points = new Float32List(waveData.length * 4);
      }
      wavePaint.strokeWidth = getHeight() * strokeWidth;
      double angle = 0;

      for (int i = 0; i < 360; i++, angle++) {

        points[i * 4] =  getWidth() / 2
            + waveData[i * 2].abs()
            // add multiplier
                * cos(radians(angle)) ;
        points[i * 4 + 1] = getWidth() / 2
            + waveData[i * 2].abs()
                * sin(radians(angle));

        points[i * 4 + 2] = getWidth() / 2
            + waveData[i * 2 + 1].abs()
                * cos(radians(angle  +1));

        points[i * 4 + 3] = getWidth() / 2
            + waveData[i * 2 + 1].abs()
                * sin(radians(angle  +1));
      }

      canvas.drawRawPoints(PointMode.lines, points, wavePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  getHeight() {
    return height;
  }

  getWidth() {
    return width;
  }

}
