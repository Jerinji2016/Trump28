import 'package:flutter/material.dart';

class Clubs extends StatelessWidget {
  final PaintingStyle paintingStyle;
  Clubs({this.paintingStyle: PaintingStyle.fill});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: .35,
        child: CustomPaint(
          size: Size(13, 15),
          painter: Club(paintingStyle: this.paintingStyle),
        ),);
  }
}

class Club extends CustomPainter {
  final PaintingStyle paintingStyle;
  Club({this.paintingStyle});

  @override
  void paint(Canvas canvas, Size size) {
    double cx = size.width / 2, cy = size.height / 2;

    Paint paint = Paint()
      ..color = Colors.black
      ..style = this.paintingStyle;

    Path path = Path();
    path.addOval(Rect.fromCircle(
      center: Offset(cx, cy - 12),
      radius: 11.0,
    ));
    path.addOval(Rect.fromCircle(
      center: Offset(cx - 10, cy + 4),
      radius: 11.0,
    ));
    path.addOval(Rect.fromCircle(
      center: Offset(cx + 10, cy + 4),
      radius: 11.0,
    ));

    path.moveTo(cx, cy);
    path.quadraticBezierTo(cx, cy + 23, cx + 10, cy + 23);
    path.lineTo(cx - 10, cy + 23);
    path.quadraticBezierTo(cx, cy + 23, cx, cy);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
