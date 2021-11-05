import 'package:flutter/material.dart';
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

  List<PlayCard> get cards => game.myHand.cards;

  int get noOfCards => cards.length;

  late List<Widget> cardsWidget = [];

  @override
  void initState() {
    List<String> _cards = ["SK", "CJ", "CA", "H7", "DT", "H9"];
    game = Provider.of<Game>(context, listen: false);

    _cards.reversed.forEach(
      (element) => cards.add(
        PlayCard(element),
      ),
    );

    super.initState();
  }

  void _onCardSelected(PlayCard card) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double sidePadding = MediaQuery.of(context).size.width * 0.2;

    return ChangeNotifierProvider(
      create: (context) => game.myHand,
      builder: (context, child) {
        int i = 1;
        cardsWidget = cards.map((e) {
          return e.getWidget(context, i++, _onCardSelected);
        }).toList();

        return Positioned(
          bottom: 50.0,
          left: sidePadding,
          right: sidePadding,
          child: Container(
            height: 120.0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: cardsWidget,
            ),
          ),
        );
      },
    );
  }
}
