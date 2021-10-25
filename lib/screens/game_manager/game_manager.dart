import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/enums/game_stage.dart';
import 'package:trump28/modals/game.dart';
import 'package:trump28/modals/player.dart';
import 'package:trump28/screens/game_manager/game_table.dart';
import 'package:trump28/screens/game_manager/waiting_lobby.dart';
import 'package:trump28/utils/firestore.dart';
import 'package:trump28/widget/gradient_background.dart';

import 'player_missing.dart';

class GameManager extends StatefulWidget {
  final Game game;

  const GameManager(this.game, {Key? key}) : super(key: key);

  @override
  _GameManagerState createState() => _GameManagerState();
}

class _GameManagerState extends State<GameManager> {
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
          updateShouldNotify: (oGame, nGame) {
            if (nGame.players.length != oGame.players.length) return true;

            for (Player player in oGame.players) {
              int nGamePlayerIndex = oGame.players.indexWhere((element) => element.id == player.id);
              if ((nGamePlayerIndex < 0) && (oGame.stage != nGame.stage)) return true;
              if (player.map.toString() != nGame.players.elementAt(nGamePlayerIndex).map.toString()) return true;
            }
            return false;
          },
          builder: (context, child) {
            Game game = Provider.of<Game>(context);
            switch (game.stage) {
              case GameStage.WaitingLobby:
                return WaitingLobby();
              case GameStage.Dealing:
              case GameStage.InGame:
                return GameTable();
              case GameStage.GameOver:
                // TODO: Handle this case.
                break;
              case GameStage.ErrorPlayerMissing:
                return PlayerMissing();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
