import 'package:flutter/material.dart';

class Diamonds extends StatelessWidget {
  final PaintingStyle paintingStyle;
  Diamonds({this.paintingStyle : PaintingStyle.fill});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: .35,
        child: CustomPaint(
          size: Size(12, 15),
          painter: Diamond(paintingStyle: this.paintingStyle),
        ),);
  }
}

class Diamond extends CustomPainter {
  final PaintingStyle paintingStyle;
  Diamond({this.paintingStyle});

  @override
  void paint(Canvas canvas, Size size) {
    double cx = size.width / 2, cy = size.height / 2;

    Paint paint = Paint()
      ..color = Colors.red
      ..style = this.paintingStyle;

    Path path = Path()..moveTo(cx, cy - 23);
    path.lineTo(cx + 18, cy);
    path.lineTo(cx, cy + 23);
    path.lineTo(cx - 18, cy);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
