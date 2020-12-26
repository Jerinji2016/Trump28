import 'package:flutter/material.dart';

class Spades extends StatelessWidget {
  final PaintingStyle paintingStyle;
  Spades({this.paintingStyle: PaintingStyle.fill});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.scale(
        scale: .35,
        child: CustomPaint(
          size: Size(13, 15),
          painter: Spade(),
        ),
      ),
    );
  }
}

class Spade extends CustomPainter {
  final PaintingStyle paintingStyle;
  Spade({this.paintingStyle});
  @override
  void paint(Canvas canvas, Size size) {
    double cx = size.width / 2, cy = size.height / 2;

    Paint paint = Paint()
      ..color = Colors.black
      ..style = this.paintingStyle;

    Path path = Path()..moveTo(cx, cy);
    path.quadraticBezierTo(cx, cy + 25, cx + 17, cy + 23);
    path.lineTo(cx - 17, cy + 23);
    path.quadraticBezierTo(cx, cy + 23, cx, cy);

    path.moveTo(cx, cy + 10);
    path.arcToPoint(
      Offset(cx - 20, cy - 3),
      radius: Radius.circular(10.0),
    );
    path.lineTo(cx, cy - 23);
    path.lineTo(cx + 20, cy - 3);
    path.arcToPoint(
      Offset(cx, cy + 10),
      radius: Radius.circular(10.0),
    );

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
