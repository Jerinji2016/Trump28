import 'package:flutter/material.dart';

class RoomTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0, left: 80.0, right: 80.0, top: 20.0),
      child: Center(
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: TablePainter(),
        ),
      ),
    );
  }
}

class TablePainter extends CustomPainter {
  static const double _INNER_MARGIN = 25;
  static const double _OUTER_MARGIN = 10;
  static const double _BOTTOM_MARGIN = 16;

  @override
  void paint(Canvas canvas, Size size) {
    double cx = size.width / 2, cy = size.height / 2;

    Paint tableOutPaint = Paint()
      ..color = Colors.blueGrey[900]!
      ..style = PaintingStyle.fill;

    Path tableOut = Path();
    tableOut.moveTo(cx, _OUTER_MARGIN);
    tableOut.lineTo(cx + (cx * .3), _OUTER_MARGIN);
    tableOut.quadraticBezierTo(
      (2 * cx) - _OUTER_MARGIN,
      _OUTER_MARGIN,
      (2 * cx) - _OUTER_MARGIN,
      cy,
    );
    tableOut.quadraticBezierTo(
      (2 * cx) - _OUTER_MARGIN,
      (2 * cy) - _OUTER_MARGIN,
      cx + (cx * .3),
      (2 * cy) - _OUTER_MARGIN,
    );
    tableOut.lineTo(cx - (cx * .3), (2 * cy) - _OUTER_MARGIN);
    tableOut.quadraticBezierTo(
      _OUTER_MARGIN,
      (2 * cy) - _OUTER_MARGIN,
      _OUTER_MARGIN,
      cy,
    );
    tableOut.quadraticBezierTo(
      _OUTER_MARGIN,
      _OUTER_MARGIN,
      cx - (cx * .3),
      _OUTER_MARGIN,
    );

    tableOut.close();
    canvas.drawPath(tableOut, tableOutPaint);

    Paint tableInPaint = Paint()
      ..color = Colors.blueGrey[600]!
      ..style = PaintingStyle.fill;

    Path tableIn = Path();
    tableIn.moveTo(cx, _INNER_MARGIN);
    tableIn.lineTo(cx + (cx * .3), _INNER_MARGIN);
    tableIn.quadraticBezierTo(
      (2 * cx) - _INNER_MARGIN,
      _INNER_MARGIN,
      (2 * cx) - _INNER_MARGIN,
      cy,
    );
    tableIn.quadraticBezierTo(
      (2 * cx) - _INNER_MARGIN,
      (2 * cy) - _BOTTOM_MARGIN,
      cx + (cx * .3),
      (2 * cy) - _BOTTOM_MARGIN,
    );
    tableIn.lineTo(cx - (cx * .3), (2 * cy) - _BOTTOM_MARGIN);
    tableIn.quadraticBezierTo(
      _INNER_MARGIN,
      (2 * cy) - _BOTTOM_MARGIN,
      _INNER_MARGIN,
      cy,
    );
    tableIn.quadraticBezierTo(
      _INNER_MARGIN,
      _INNER_MARGIN,
      cx - (cx * .3),
      _INNER_MARGIN,
    );

    tableIn.close();
    canvas.drawPath(tableIn, tableInPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
