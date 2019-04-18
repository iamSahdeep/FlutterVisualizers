import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math_64.dart';

class CircularBarVisualizer extends CustomPainter {

  final List<int> waveData;
  Float32List points;
  final double height;
  final double width;
  final Color color;
  final Paint wavePaint;
  final int density ;
  final int gap ;
  double radius = -1;

  CircularBarVisualizer({
    @required this.waveData,
    @required this.height,
    @required this.width,
    @required this.color,
    this.density = 100,
    this.gap = 2
  }) : wavePaint = new Paint()
    ..color = color.withOpacity(1.0)
    ..style = PaintingStyle.fill,
        assert(waveData != null),
        assert(height!= null),
        assert(width != null),
        assert(color != null);

  @override
  void paint(Canvas canvas, Size size) {

    if (radius == -1) {
      radius = getHeight() < getWidth() ? getHeight() : getWidth();
      radius =  (radius * 0.65 / 2);
      double circumference = 2 * 3.141 * radius;
      wavePaint.strokeWidth = circumference/120;
      wavePaint.style = PaintingStyle.stroke;
    }
    canvas.drawCircle(new Offset(getWidth() / 2, getHeight() / 2), radius.toDouble(), wavePaint);
    if (waveData != null) {
      if (points == null || points.length < waveData.length * 4) {
        points = new Float32List(waveData.length * 4);
      }
      double angle = 0;

      for (int i = 0; i < 120; i++, angle += 3) {
        int x = (i * 8.5).ceil();
        int t = (((-(waveData[x]).abs() + 128)) * (getHeight()/4) ~/ 128).abs();

        points[i * 4] = getWidth() / 2
            + radius
                * cos(radians(angle));

        points[i * 4 + 1] = getHeight() / 2
            + radius
                *sin(radians(angle));

        points[i * 4 + 2] =getWidth() / 2
            + (radius + t)
                * cos(radians(angle));

        points[i * 4 + 3] =  getHeight() / 2
            + (radius + t)
                *sin(radians(angle));
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
