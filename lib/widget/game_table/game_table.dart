import 'package:flutter/material.dart';

import 'player_seats.dart';
import 'table_bg.dart';

class GameTable extends StatefulWidget {
  final int noOfPlayers;
  const GameTable(this.noOfPlayers, {Key? key}) : super(key: key);

  @override
  _GameTableState createState() => _GameTableState();
}

class _GameTableState extends State<GameTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          TableBackground(),
          PlayerSeats(),
        ],
      ),
    );
  }
}
