import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/modals/card.dart';
import 'package:trump28/modals/game.dart';

class PlayerHand extends StatefulWidget {
  const PlayerHand({Key? key}) : super(key: key);

  @override
  _PlayerHandState createState() => _PlayerHandState();
}

class _PlayerHandState extends State<PlayerHand> {
  late Game game;

  List<PlayCard> cards = [];

  int get noOfCards => cards.length;

  late List<Widget> cardsWidget = [];

  @override
  void initState() {
    List<String> _cards = ["SK", "CJ", "CA", "H7", "DT", "H9"];
    _cards.reversed.forEach(
      (element) => cards.add(
        PlayCard(element),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(noOfCards);
    game = Provider.of<Game>(context);
    double sidePadding = MediaQuery.of(context).size.width * 0.2;

    int i = 0;
    cardsWidget = cards.map((e) {
      i++;
      return e.getWidget(context, i * 35.0);
    }).toList();

    return Positioned(
      bottom: 70.0,
      left: sidePadding,
      right: sidePadding,
      child: Container(
        height: 110.0,
        child: Stack(
          children: cardsWidget,
        ),
      ),
    );
  }
}
