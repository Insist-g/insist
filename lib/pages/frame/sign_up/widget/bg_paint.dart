import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BgPainter extends CustomPainter {
  final _path = Path();
  final _paint = Paint()
    ..strokeWidth = 4
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    _paint.shader = LinearGradient(
      colors: [
        Color(0XffCACCFF),
        Color(0Xff7A80FF),
        Color(0Xff9F5F9F),
        Color(0Xff4B0082),
        Color(0Xff4B0082),
      ],
    ).createShader(Rect.fromLTRB(30, 0, size.width * 2, size.height / 3));
    _path.moveTo(30, 0);
    _path.quadraticBezierTo(
        size.width / 5, size.height / 10, size.width / 2.5, size.height / 10);
    _path.quadraticBezierTo(
        size.width / 2, size.height / 3, size.width, size.height / 3);
    _path.lineTo(size.width, 0);
    canvas.drawCircle(Offset(size.width / 5, size.height / 5), 40, _paint);

    return canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
