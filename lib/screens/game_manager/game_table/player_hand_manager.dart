import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/enums/game_stage.dart';
import 'package:trump28/providers/game.dart';

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
    String dealer = "";

    if (gameStage == GameStage.AllPlayersReady) return DealingCards();
    return PlayerHand();
  }
}

class DealingCards extends StatelessWidget {
  const DealingCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
