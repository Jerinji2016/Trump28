import 'package:flutter/material.dart';

import 'player_seats.dart';
import 'table_bg.dart';

class GameTable extends StatefulWidget {
  const GameTable({Key? key}) : super(key: key);

  @override
  _GameTableState createState() => _GameTableState();
}

class _GameTableState extends State<GameTable> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 20.0, left: 80.0, right: 80.0, top: 20.0),
          child: TableBackground(),
        ),
        PlayerSeats(),
      ],
    );
  }
}
