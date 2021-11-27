import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:trump28/modals/play_card.dart';
import 'package:trump28/providers/game.dart';

class PlayerHand extends StatefulWidget {
  const PlayerHand({Key? key}) : super(key: key);

  @override
  _PlayerHandState createState() => _PlayerHandState();
}

class _PlayerHandState extends State<PlayerHand> {
  late Game game;

  late List<PlayCard> cards;

  int get noOfCards => cards.length;

  @override
  void initState() {
    game = Provider.of<Game>(context, listen: false);
    cards = game.myHand.cards;

    super.initState();
  }

  void _onCardSelected(PlayCard card) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double sidePadding = MediaQuery.of(context).size.width * 0.2;

    int i = 1;
    return Positioned(
      bottom: 50.0,
      left: sidePadding,
      right: sidePadding,
      child: Container(
        height: 120.0,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: cards.map((e) {
            return e.getWidget(context, i++, _onCardSelected);
          }).toList(),
        ),
      ),
    );
  }
}
