import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'dart:math';
import 'dart:ui' as ui;

class OverLayView extends StatefulWidget {
  const OverLayView({Key? key}) : super(key: key);

  @override
  State<OverLayView> createState() => _OverLayViewState();
}

class _OverLayViewState extends State<OverLayView>
    with TickerProviderStateMixin {
  static const String _kPortNameOverlay = 'OVERLAY';
  static const String _kPortNameHome = 'UI';

  SendPort? homePort;
  final _receivePort = ReceivePort();

  @override
  void initState() {
    super.initState();
    if (homePort != null) return;
    final res = IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      _kPortNameOverlay,
    );
    Log().d("$res : HOME");
    _receivePort.listen((message) {
      Log().d(message.toString(), tag: 'receivePort.listen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(4),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: SizedBox.expand(
            child: RadarView(),
          ),
        ),
        onTap: () {
          homePort ??= IsolateNameServer.lookupPortByName(
            _kPortNameHome,
          );
          homePort?.send('openApp');
        },
      ),
    );
  }
}

class RadarView extends StatefulWidget {
  @override
  _RadarViewState createState() => _RadarViewState();
}

class _RadarViewState extends State<RadarView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = Tween(begin: .0, end: pi * 2).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: RadarPainter(_animation.value),
        );
      },
    );
  }
}

class RadarPainter extends CustomPainter {
  final double angle;
  Paint _bgPaint = Paint()
    ..color = Color(0xFF2f9eff)
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  Paint _bgPaint2 = Paint()
    ..color = Color(0xFF2f9eff)
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;

  Paint _paint = Paint()..style = PaintingStyle.fill;

  int circleCount = 3;

  RadarPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = min(size.width / 2, size.height / 2);

    canvas.drawDashLine(Offset(size.width / 2, size.height / 2 - radius),
        Offset(size.width / 2, size.height / 2 + radius), 3, 1, _bgPaint);
    canvas.drawDashLine(Offset(size.width / 2 - radius, size.height / 2),
        Offset(size.width / 2 + radius, size.height / 2), 3, 1, _bgPaint);

    for (var i = 1; i <= circleCount; ++i) {
      canvas.drawCircle(Offset(size.width / 2, size.height / 2),
          radius * i / circleCount, i == 1 ? _bgPaint2 : _bgPaint);
    }

    _paint.shader = ui.Gradient.sweep(
        Offset(size.width / 2, size.height / 2),
        [Color(0xFF2f9eff).withOpacity(.1), Color(0xFF2f9eff).withOpacity(.6)],
        [.0, 1.0],
        TileMode.clamp,
        .0,
        pi / 6);

    canvas.save();
    double r = sqrt(pow(size.width, 2) + pow(size.height, 2));
    double startAngle = atan(size.height / size.width);
    Point p0 = Point(r * cos(startAngle), r * sin(startAngle));
    Point px = Point(r * cos(angle + startAngle), r * sin(angle + startAngle));
    canvas.translate((p0.x - px.x) / 2, (p0.y - px.y) / 2);
    canvas.rotate(angle);

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        0,
        pi / 1.5,
        true,
        _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

extension CanvasExt on Canvas {
  ///绘制虚线
  ///[p1] 起点
  ///[p2] 终点
  ///[dashWidth] 实线宽度
  ///[spaceWidth] 空隙宽度
  void drawDashLine(
    Offset p1,
    Offset p2,
    double dashWidth,
    double spaceWidth,
    Paint paint,
  ) {
    assert(dashWidth > 0);
    assert(spaceWidth > 0);

    double radians;

    if (p1.dx == p2.dx) {
      radians = (p1.dy < p2.dy) ? pi / 2 : pi / -2;
    } else {
      radians = atan2(p2.dy - p1.dy, p2.dx - p1.dx);
    }

    this.save();
    this.translate(p1.dx, p1.dy);
    this.rotate(radians);

    var matrix = Matrix4.identity();
    matrix.translate(p1.dx, p1.dy);
    matrix.rotateZ(radians);
    matrix.invert();

    var endPoint = MatrixUtils.transformPoint(matrix, p2);

    double tmp = 0;
    double length = endPoint.dx;
    double delta;

    while (tmp < length) {
      delta = (tmp + dashWidth < length) ? dashWidth : length - tmp;
      this.drawLine(Offset(tmp, 0), Offset(tmp + delta, 0), paint);
      if (tmp + delta >= length) {
        break;
      }

      tmp = (tmp + dashWidth + spaceWidth < length)
          ? (tmp + dashWidth + spaceWidth)
          : (length);
    }

    this.restore();
  }
}
