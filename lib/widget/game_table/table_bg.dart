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
  double INNER_MARGIN = 25;
  double OUTER_MARGIN = 10;
  double BOTTOM_MARGIN = 16;

  @override
  void paint(Canvas canvas, Size size) {
    double cx = size.width / 2, cy = size.height / 2;

    Paint tableOutPaint = Paint()
      ..color = Colors.blueGrey[900]!
      ..style = PaintingStyle.fill;

    Path tableOut = Path();
    tableOut.moveTo(cx, OUTER_MARGIN);
    tableOut.lineTo(cx + (cx * .3), OUTER_MARGIN);
    tableOut.quadraticBezierTo(
      (2 * cx) - OUTER_MARGIN,
      OUTER_MARGIN,
      (2 * cx) - OUTER_MARGIN,
      cy,
    );
    tableOut.quadraticBezierTo(
      (2 * cx) - OUTER_MARGIN,
      (2 * cy) - OUTER_MARGIN,
      cx + (cx * .3),
      (2 * cy) - OUTER_MARGIN,
    );
    tableOut.lineTo(cx - (cx * .3), (2 * cy) - OUTER_MARGIN);
    tableOut.quadraticBezierTo(
      OUTER_MARGIN,
      (2 * cy) - OUTER_MARGIN,
      OUTER_MARGIN,
      cy,
    );
    tableOut.quadraticBezierTo(
      OUTER_MARGIN,
      OUTER_MARGIN,
      cx - (cx * .3),
      OUTER_MARGIN,
    );

    tableOut.close();
    canvas.drawPath(tableOut, tableOutPaint);

    Paint tableInPaint = Paint()
      ..color = Colors.blueGrey[600]!
      ..style = PaintingStyle.fill;

    Path tableIn = Path();
    tableIn.moveTo(cx, INNER_MARGIN);
    tableIn.lineTo(cx + (cx * .3), INNER_MARGIN);
    tableIn.quadraticBezierTo(
      (2 * cx) - INNER_MARGIN,
      INNER_MARGIN,
      (2 * cx) - INNER_MARGIN,
      cy,
    );
    tableIn.quadraticBezierTo(
      (2 * cx) - INNER_MARGIN,
      (2 * cy) - BOTTOM_MARGIN,
      cx + (cx * .3),
      (2 * cy) - BOTTOM_MARGIN,
    );
    tableIn.lineTo(cx - (cx * .3), (2 * cy) - BOTTOM_MARGIN);
    tableIn.quadraticBezierTo(
      INNER_MARGIN,
      (2 * cy) - BOTTOM_MARGIN,
      INNER_MARGIN,
      cy,
    );
    tableIn.quadraticBezierTo(
      INNER_MARGIN,
      INNER_MARGIN,
      cx - (cx * .3),
      INNER_MARGIN,
    );

    tableIn.close();
    canvas.drawPath(tableIn, tableInPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
