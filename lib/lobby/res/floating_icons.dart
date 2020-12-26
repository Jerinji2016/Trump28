import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trump28/res/clubs.dart';
import 'package:trump28/res/hearts.dart';
import 'package:trump28/res/spades.dart';

class FloatingIconBackground extends StatefulWidget {
  @override
  _FloatingIconBackgroundState createState() => _FloatingIconBackgroundState();
}

class _FloatingIconBackgroundState extends State<FloatingIconBackground>
    with SingleTickerProviderStateMixin {
  double x, y, cx, cy;

  AnimationController _controller;
  Animation<double> _animation;

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    super.initState();

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    x = size.width;
    y = size.height;
    cx = x / 2;
    cy = y / 2;

    double iconSize = 60.0;

    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: calculate(_animation.value, path1()).dy,
            left: calculate(_animation.value, path1()).dx,
            child: Transform.scale(
              scale: 3,
              child: Clubs(),
            ),
          ),
          Positioned(
            top: calculate(_animation.value, path2()).dy,
            left: calculate(_animation.value, path2()).dx,
            child: Transform.scale(
              scale: 3,
              child: Clubs(),
            ),
          ),
          Positioned(
            top: calculate(_animation.value, path3()).dy,
            left: calculate(_animation.value, path3()).dx,
            child: Transform.scale(
              scale: 3,
              child: Clubs(),
            ),
          ),
          Positioned(
            top: calculate(_animation.value, path4()).dy,
            left: calculate(_animation.value, path4()).dx,
            child: Transform.scale(
              scale: 3,
              child: Clubs(),
            ),
          ),
        ],
      ),
    );
  }

  Path path1() {
    Path path = Path();
    path.moveTo(cx, cy);
    path.quadraticBezierTo(cx - 100, cy, cx - 150, cy - 100);
    path.quadraticBezierTo(cx - 200, cy - 200, 120, cy - 100);
    path.quadraticBezierTo(-50, cy + 100, cx + 200, cy - 100);
    path.quadraticBezierTo(x + 100, 20, (2 * cx) - 100, cy);
    path.quadraticBezierTo(x - 200, cy + 100, cx + 100, cy);
    path.quadraticBezierTo(cx + 70, cy - 30, cx + 40, cy - 10);
    path.quadraticBezierTo(cx + 20, cy, cx, cy);
    return path;
  }

  Path path2() {
    Path path = Path();

    path.moveTo(80, 60);
    path.quadraticBezierTo(cx, y, x - 100, y - 80);
    path.quadraticBezierTo(x, cy, 80, 60);

    return path;
  }

  Path path3() {
    Path path = Path();
    path.moveTo(60, y - 80);
    path.quadraticBezierTo(x - 100, y, x - 80, cy);
    path.quadraticBezierTo(x - 50, 80, cx, 50);
    path.quadraticBezierTo(80, 80, 60, y - 80);
    return path;
  }

  Path path4() {
    Path path = Path();
    path.moveTo(x - 50, y - 150);
    path.quadraticBezierTo(x, 100, 200, 60);
    path.quadraticBezierTo(-50, 50, 100, y - 150);
    path.quadraticBezierTo(cx, y + 50, x - 50, y - 150);

    return path;
  }

  Offset calculate(value, Path path) {
    PathMetrics pathMetrics = path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.position;
  }
}

class FloatingPath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double cx = size.width / 2, cy = size.height / 2;
    double x = size.width, y = size.height;

    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    Path path1 = Path(), path2 = Path(), path3 = Path(), path4 = Path();

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
    canvas.drawPath(path3, paint);
    canvas.drawPath(path4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
