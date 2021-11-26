import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/enums/game_stage.dart';
import 'package:trump28/providers/game.dart';
import 'package:trump28/screens/game_manager/game_table/game_table.dart';
import 'package:trump28/screens/game_manager/waiting_lobby.dart';
import 'package:trump28/utils/firestore.dart';
import 'package:trump28/utils/trump_api.dart';
import 'package:trump28/widget/gradient_background.dart';

import 'game_over.dart';
import 'player_missing.dart';

class GameManager extends StatefulWidget {
  final Game game;

  const GameManager(this.game, {Key? key}) : super(key: key);

  @override
  _GameManagerState createState() => _GameManagerState();
}

class _GameManagerState extends State<GameManager> {
  late Game game;

  @override
  void dispose() {
    TrumpApi.leaveSeat(game.roomId, game.mySeat);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GradientBackground(
        child: StreamProvider<Game>(
          initialData: widget.game,
          create: (BuildContext context) => Firestore.getRoomStream(widget.game.roomId),
          catchError: (context, _) {
            print("error: $_");
            return widget.game;
          },
          updateShouldNotify: (oGame, nGame) => true,
          builder: (context, child) {
            game = Provider.of<Game>(context);

            return WillPopScope(
              child: Builder(
                builder: (context) {
                  switch (game.stage) {
                    case GameStage.WaitingLobby:
                      return WaitingLobby();
                    case GameStage.AllPlayersReady:
                    case GameStage.Dealing1:
                    case GameStage.FirstAuction:
                    case GameStage.Dealing2:
                    case GameStage.FinalAuction:
                    case GameStage.InGame:
                      return GameTable();
                    case GameStage.GameOver:
                      return GameOver();
                    case GameStage.ErrorPlayerMissing:
                      return PlayerMissing();
                  }
                },
              ),
              onWillPop: () async {
                await TrumpApi.leaveSeat(game.roomId, game.mySeat);
                return true;
              },
            );
          },
        ),
      ),
    );
  }
}
