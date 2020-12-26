import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:trump28/game/res/player.dart';
import 'package:trump28/helper/game.dart';

class PlayerSeats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: playerSeatings(context),
      ),
    );
  }

  List<Widget> playerSeatings(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> players = new List();
    players.addAll([
      Positioned(
        left: -10,
        top: size.height / 2 - 35,
        child: Player(
          angle: math.pi / 2,
          noOfCards: 8,
          size: 100,
        ),
      ),
      Positioned(
        right: -10,
        top: size.height / 2 - 35,
        child: Player(
          angle: (3 * math.pi) / 2,
          noOfCards: 8,
          size: 100,
        ),
      ),
    ]);

    if (Game.noOfPlayers == 4) {
      players.add(
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Player(
            angle: math.pi,
            noOfCards: 8,
            size: 100,
          ),
        ),
      );

      return players;
    }

    players.addAll([
      Positioned(
        left: size.width/7,
        top: 15,
        child: Player(
          angle: math.pi - (math.pi/14),
          noOfCards: 8,
          size: 100,
        ),
      ),
      Positioned(
        right: 0,
        left: 0,
        top: 0,
        child: Player(
          angle: math.pi,
          noOfCards: 8,
          size: 100,
        ),
      ),
      Positioned(
        top: 15,
        right: size.width/7,
        child: Player(
          angle: math.pi + (math.pi/14),
          noOfCards: 8,
          size: 100,
        ),
      ),
    ]);

    return players;
  }
}
