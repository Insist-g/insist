import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final Color color; // 虚线颜色
  final double strokeWidth; // 虚线粗细
  final double gapWidth; // 虚线间隙宽度

  DashedLinePainter({required this.color, required this.strokeWidth, required this.gapWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double halfGap = gapWidth / 2;
    final double startY = size.height / 2;

    for (double startX = 0; startX < size.width; startX += gapWidth) {
      canvas.drawLine(Offset(startX, startY), Offset(startX + halfGap, startY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
