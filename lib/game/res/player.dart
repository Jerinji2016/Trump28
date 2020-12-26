import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final double size, angle;
  final int noOfCards;

  Player({
    this.noOfCards: 6,
    this.size: 70,
    this.angle: 0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: this.angle,
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: card(),
            ),
          ),
          Container(
            height: 50.0,
            child: CustomPaint(
              size: Size(this.size, this.size),
              painter: PlayerPaint(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> card() {
    List<Widget> cards = new List();
    List<Widget> card = [Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white70,
      ),
      width: 8.0,
      height: 8.0,
    ),SizedBox(width: 3.0)];

    for (int x = 0; x < this.noOfCards; x++) cards.addAll(card);

    return cards;
  }
}

class PlayerPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double cx = size.width / 2, cy = size.height / 2;

    Paint bodyPaint = Paint()
          ..color = Colors.blue[500]
          ..style = PaintingStyle.fill,
        headPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill;

    Path bodyPath = Path()..moveTo(cx, cy);
    Path headPath = Path()..moveTo(cx, cy);
    bodyPath.addRRect(RRect.fromLTRBR(
        cx - 35, cy - 20, cx + 35, cy + 20, Radius.circular(10.0)));

    headPath
        .addOval(Rect.fromCircle(center: Offset(cx, cy + 12), radius: 20.0));
    bodyPath.close();
    canvas.drawPath(bodyPath, bodyPaint);
    canvas.drawPath(headPath, headPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
