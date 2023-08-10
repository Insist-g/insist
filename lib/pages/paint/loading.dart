import 'package:flutter/material.dart';

class LoadingView extends CustomPainter {
  int progress = 0;

  LoadingView({required this.progress});

  Path leftPath = Path();
  Path rightPath = Path();

  static const pink = Colors.white;
  final _paint1 = Paint()
    ..color = pink
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    var pStart = Offset(size.width / 2, size.height);
    var pEnd = Offset(size.width / 2, size.height * 0.2);

    var p1 = Offset(size.width * 0.7, size.height * (-0.2));
    var p2 = Offset(size.width * 1.5, size.height * 0.5);

    var p3 = Offset(size.width * 0.3, size.height * (-0.2));
    var p4 = Offset(size.width * (-0.5), size.height * 0.5);

    rightPath.moveTo(pStart.dx, pStart.dy);
    rightPath.cubicTo(p2.dx, p2.dy, p1.dx, p1.dy, pEnd.dx, pEnd.dy);
    rightPath.moveTo(pStart.dx, pStart.dy);
    rightPath.cubicTo(p4.dx, p4.dy, p3.dx, p3.dy, pEnd.dx, pEnd.dy);
    canvas.drawPath(leftPath, _paint1);
    canvas.drawPath(rightPath, _paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LoadingClipper extends CustomClipper<Path> {
  final _path = Path();

  @override
  Path getClip(Size size) {
    var pStart = Offset(size.width / 2, size.height);
    var pEnd = Offset(size.width / 2, size.height * 0.2);

    var p1 = Offset(size.width * 0.7, size.height * (-0.2));
    var p2 = Offset(size.width * 1.5, size.height * 0.5);

    var p3 = Offset(size.width * 0.3, size.height * (-0.2));
    var p4 = Offset(size.width * (-0.5), size.height * 0.5);
    _path.moveTo(pStart.dx, pStart.dy);
    _path.cubicTo(p2.dx, p2.dy, p1.dx, p1.dy, pEnd.dx, pEnd.dy);
    _path.moveTo(pStart.dx, pStart.dy);
    _path.cubicTo(p4.dx, p4.dy, p3.dx, p3.dy, pEnd.dx, pEnd.dy);
    return _path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class LoadingPaint extends CustomPainter {
  double progress = 0; // 0 - 1

  LoadingPaint({required this.progress});

  final _path = Path();
  final _paint = Paint()
    ..color = Colors.pink
    ..strokeWidth = 4
    ..style = PaintingStyle.fill;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _path.moveTo(0, size.height / 2);
    _path.quadraticBezierTo(size.width / 4 ,-110, size.width / 2, size.height / 2);
    _path.quadraticBezierTo(size.width *0.7 ,410, size.width, size.height / 2);
    return canvas.drawPath(_path, _paint);
  }
}
