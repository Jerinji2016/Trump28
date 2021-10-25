import 'package:flutter/material.dart';
import 'package:trump28/widget/game_table/player_seats.dart';
import 'package:trump28/widget/game_table/room_bg.dart';

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
        Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50.0),
                    child: InkWell(
                      splashColor: Colors.black38,
                      borderRadius: BorderRadius.circular(50.0),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.arrow_back_outlined,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: Text(
                      "Waiting for players",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                width: 650.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Stack(
                  children: [
                    RoomTable(),
                    PlayerSeats(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
