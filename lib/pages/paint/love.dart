import 'package:flutter/material.dart';

import 'loading.dart';

class LovePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 300,
              height: 300,
              color: Colors.amberAccent,
              child: CustomPaint(
                painter: LoadingPaint(progress: 0),
              ),
            ),
            // ClipPath(
            //   clipper:LoadingClipper(),
            //   child: Container(
            //     width: 40,
            //     height: 40,
            //     color: Colors.amber,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

///贝尔赛曲线大致绘制网址 https://www.desmos.com/calculator/cahqdxeshd?lang=zh-CN
class BezierPainter extends CustomPainter {

  Path leftPath = Path();
  Path rightPath = Path();
  static const pink = Colors.pink;
  final _paint1 = Paint()
    ..color = pink
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    // var p0 = Offset(size.width / 2, size.height);       //起始点
    // var p3 = Offset(p0.dx, size.height * 0.6);          //结束点
    //
    // var p1 = Offset(size.width * 0.2, size.height * 0.3);       //左侧曲线控制点p1
    // var p2 = Offset(-100, size.height * 0.8);                   //左侧曲线控制点p2
    //
    // leftPath.moveTo(p0.dx, p0.dy);        //设置起始点为 p0
    // leftPath.cubicTo(p2.dx, p2.dy, p1.dx, p1.dy, p3.dx, p3.dy);     //控制点p2,控制点p1,结束点p3
    //
    // var p4 = Offset(size.width * 0.8, size.height * 0.3);
    // var p5 = Offset(size.width + 100, size.height * 0.8);
    //
    // rightPath.moveTo(p0.dx, p0.dy);
    // rightPath.cubicTo(p5.dx, p5.dy, p4.dx, p4.dy, p3.dx, p3.dy);
    // canvas.drawPath(leftPath, _paint1);
    // canvas.drawPath(rightPath, _paint1);

    var pStart = Offset(size.width/2, size.height);
    var pEnd = Offset(size.width/2, size.height * 0.2);
    
    var p1 = Offset(size.width * 0.7, size.height * (-0.2));
    var p2 = Offset(size.width * 1.5, size.height * 0.5);

    var p3 = Offset(size.width * 0.3, size.height * (-0.2));
    var p4 = Offset(size.width * (-0.5), size.height * 0.5);

    rightPath.moveTo(pStart.dx, pStart.dy);
    rightPath.cubicTo( p2.dx, p2.dy,p1.dx, p1.dy, pEnd.dx, pEnd.dy);
    rightPath.moveTo(pStart.dx, pStart.dy);
    rightPath.cubicTo( p4.dx, p4.dy,p3.dx, p3.dy, pEnd.dx, pEnd.dy);
    canvas.drawPath(leftPath, _paint1);
    canvas.drawPath(rightPath, _paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

class BottomClipperTest extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2.0, 0);
    path.arcToPoint(Offset(size.width / 2.0, size.width),
        clockwise: false, radius: Radius.circular(size.width / 2.0));
    path.moveTo(size.width / 2.0, size.width);
    path.arcToPoint(Offset(size.width / 2.0, 0),
        clockwise: false, radius: Radius.circular(size.width / 2.0));
    return path;
  }

  @override
  bool shouldReclip(BottomClipperTest oldClipper) => true;
}