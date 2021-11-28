import 'package:flutter/material.dart';
import 'package:trump28/res/trump28.dart';
import 'package:trump28/screens/game_manager/game_table/player_hand_manager.dart';

import '../room_bg/player_seats.dart';
import '../room_bg/room_bg.dart';
import 'bidding_panel.dart';
import 'game_chat.dart';

class GameTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          right: -40,
          child: Transform.scale(
            scale: 0.5,
            child: Trump28(),
          ),
        ),
        Column(
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
            Expanded(
              child: Container(
                width: 650.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Stack(
                  children: [
                    RoomTable(),
                    PlayerSeats(isServerSeat: false),
                    PlayerHandManager(),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: GameChat(),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: 150.0,
          child: BiddingPanel(),
        )
      ],
    );
  }
}
