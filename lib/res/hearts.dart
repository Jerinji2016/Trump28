import 'package:flutter/material.dart';

class Hearts extends StatelessWidget {
  final PaintingStyle paintingStyle;
  Hearts({this.paintingStyle: PaintingStyle.fill});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -1.5),
      child: Transform.scale(
          scale: .35,
          child: CustomPaint(
            size: Size(13, 15),
            painter: Heart(),
          )),
    );
  }
}

class Heart extends CustomPainter {
  final PaintingStyle paintingStyle;
  Heart({this.paintingStyle});

  @override
  void paint(Canvas canvas, Size size) {
    double cx = size.width / 2, cy = size.height / 2;

    Paint paint = Paint()
      ..color = Colors.red
      ..style = this.paintingStyle;

    Path path = Path()..moveTo(cx, cy - 15);

    path.arcToPoint(
      Offset(cx + 20, cy + 5),
      radius: Radius.circular(10.0),
      largeArc: true,
    );
    path.lineTo(cx, cy + 25);
    path.lineTo(cx - 20, cy + 5);
    path.arcToPoint(
      Offset(cx, cy - 15),
      radius: Radius.circular(10.0),
      largeArc: true,
    );

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
