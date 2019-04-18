import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

class LineVisualizer extends CustomPainter {

  final List<int> waveData;
  final double height;
  final double width;
  final Color color;
  final Paint wavePaint;
  Float32List points;
  Rect rect;
  final double strokeWidth ;

  LineVisualizer({
    @required this.waveData,
    @required this.height,
    @required this.width,
    @required this.color,
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
      wavePaint.strokeWidth = height * strokeWidth;
      rect = new Rect.fromLTWH(0, 0, width, height/ 3);
      for (int i = 0; i < waveData.length - 1 ; i++) {
        points[i * 4] = rect.width * i / (waveData.length - 1);
        points[i * 4 + 1] = rect.height / 2
            + ((waveData[i] + 128)) * (rect.height / 3) / 128;
        points[i * 4 + 2] = rect.width* (i + 1) / (waveData.length - 1);
        points[i * 4 + 3] = rect.height / 2
            + ((waveData[i + 1] + 128)) * (rect.height / 3) / 128;
      }
      canvas.drawRawPoints(PointMode.lines, points, wavePaint);

    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

