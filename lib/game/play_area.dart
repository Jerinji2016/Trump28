import 'package:flutter/material.dart';
import 'package:trump28/helper/constants.dart';
import 'package:trump28/game/player_seats.dart';
import 'package:trump28/game/res/table_bg.dart';

class PlayAreaTable extends StatefulWidget {
  @override
  _PlayAreaTableState createState() => _PlayAreaTableState();
}

class _PlayAreaTableState extends State<PlayAreaTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.green[700],
              Colors.green[900],
            ]),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              TableBackground(),
              PlayerSeats(),
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 4,
                    stops: [.18, .4,],
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  PlayArea(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayArea extends StatefulWidget {
  @override
  _PlayAreaState createState() => _PlayAreaState();
}

class _PlayAreaState extends State<PlayArea> {
  final List<String> myCards = [
    "SA",
    "DJ",
    "HQ",
    "C9",
    "SJ",
    "CJ",
    "H9",
    "C8",
  ];

  double offset = CARDS_8_OFFSET;
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .4,
      child: Stack(
        children: viewCards(context),
      ),
    );
  }

  List<Widget> viewCards(BuildContext context) {
    List<Widget> cards = new List();

    int i = 0;
    myCards.forEach((element) {
      cards.add(
        Positioned(
          right: size.width * ((i + 1) * offset),
          child: deck[myCards[i]].card(),
        ),
      );
      i++;
    });

    return cards.reversed.toList();
  }
}
