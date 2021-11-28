import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/enums/game_stage.dart';
import 'package:trump28/enums/game_type.dart';
import 'package:trump28/modals/njan.dart';
import 'package:trump28/modals/play_card.dart';
import 'package:trump28/providers/game.dart';
import 'package:trump28/utils/trump_api.dart';

import 'player_hand.dart';

class PlayerHandManager extends StatefulWidget {
  const PlayerHandManager({Key? key}) : super(key: key);

  @override
  _PlayerHandManagerState createState() => _PlayerHandManagerState();
}

class _PlayerHandManagerState extends State<PlayerHandManager> {
  late Game game;

  @override
  Widget build(BuildContext context) {
    game = Provider.of<Game>(context);

    GameStage gameStage = game.stage;

    if (gameStage == GameStage.Dealing1 && game.dealerId != null) {
      return DealingCards(game.roomId, game.type, game.dealerId!);
    }
    return PlayerHand();
  }
}

class DealingCards extends StatelessWidget {
  final String roomId;
  final String dealerId;
  final GameType type;

  const DealingCards(this.roomId, this.type, this.dealerId, {Key? key}) : super(key: key);

  static bool isDealing = false;

  void _dealCards() async {
    print('DealingCards._dealCards: ');

    isDealing = true;
    List<String> _cards = List.from(type == GameType.FourPlayer ? PlayCard.fourPlayerCards : PlayCard.sixPlayerCards);
    _cards.shuffle();
    String cardsString = _cards.join("-");
    try {
      await TrumpApi.sendShuffledCards(roomId, cardsString);
    } on Exception {
      print("________________________Exception on sendShuffledCards");
    } finally {
      isDealing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Njan njan = Njan();
    if (dealerId == njan.id && !isDealing) _dealCards();

    return Center(
      child: Text(
        "Dealing...",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
