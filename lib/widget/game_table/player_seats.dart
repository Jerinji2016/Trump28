import 'package:flutter/material.dart';

class PlayerSeats extends StatefulWidget {
  const PlayerSeats({Key? key}) : super(key: key);

  @override
  _PlayerSeatsState createState() => _PlayerSeatsState();
}

class _PlayerSeatsState extends State<PlayerSeats> {
  static const int P1 = 1, P2 = 2, P3 = 3, P4 = 4, P5 = 5, P6 = 6;

  final seats = const {};

  @override
  void initState() {
    super.initState();
    initSeats();
  }

  void initSeats() {

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Seat(),
      ],
    );
  }
}

class Seat extends StatelessWidget {

  final double? top, left, right, bottom;

  const Seat({Key? key, this.top, this.left, this.right, this.bottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: SizedBox(
        height: size.height / 10,
        width: size.width / 10,
        child: Container(
          color: Colors.green,
        ),
      ),
    );
  }
}
