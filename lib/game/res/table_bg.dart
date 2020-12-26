import 'package:flutter/material.dart';

class TableBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: Table(),
      ),
    );
  }
}

class Table extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double cx = size.width / 2, cy = size.height / 2;

    Paint tableOutPaint = Paint()
      ..color = Colors.blueGrey[900]
      ..style = PaintingStyle.fill;

    Path tableOut = Path();
    tableOut.moveTo(cx, 40);
    tableOut.lineTo(cx + (cx * .3), 40);
    tableOut.quadraticBezierTo(
      (2 * cx) - 40,
      40,
      (2 * cx) - 40,
      cy,
    );
    tableOut.quadraticBezierTo(
      (2 * cx) - 40,
      (2 * cy) - 40,
      cx + (cx * .3),
      (2 * cy) - 40,
    );
    tableOut.lineTo(cx - (cx * .3), (2 * cy) - 40);
    tableOut.quadraticBezierTo(
      40,
      (2 * cy) - 40,
      40,
      cy,
    );
    tableOut.quadraticBezierTo(
      40,
      40,
      cx - (cx * .3),
      40,
    );
    
    tableOut.close();
    canvas.drawPath(tableOut, tableOutPaint);

    Paint tableInPaint = Paint()
      ..color = Colors.blueGrey[600]
      ..style = PaintingStyle.fill;

    Path tableIn = Path();
    tableIn.moveTo(cx, 60);
    tableIn.lineTo(cx + (cx * .3), 60);
    tableIn.quadraticBezierTo(
      (2 * cx) - 60,
      60,
      (2 * cx) - 60,
      cy,
    );
    tableIn.quadraticBezierTo(
      (2 * cx) - 60,
      (2 * cy) - 40,
      cx + (cx * .3),
      (2 * cy) - 40,
    );
    tableIn.lineTo(cx - (cx * .3), (2 * cy) - 40);
    tableIn.quadraticBezierTo(
      60,
      (2 * cy) - 40,
      60,
      cy,
    );
    tableIn.quadraticBezierTo(
      60,
      60,
      cx - (cx * .3),
      60,
    );
    
    tableIn.close();
    canvas.drawPath(tableIn, tableInPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
