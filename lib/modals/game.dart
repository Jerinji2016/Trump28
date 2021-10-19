import 'package:flutter/cupertino.dart';
import 'package:trump28/enums/game_stage.dart';

import 'player.dart';

enum GameType {
  SixPlayer,
  FourPlayer,
}

class Game extends ChangeNotifier {
  final GameType type;
  GameStage stage;

  final List<Player> players = [];

  Game(this.type, this.stage);

  factory Game.create(Map json) {
    GameType gameType = json["maxPlayers"] == 4 ? GameType.FourPlayer : GameType.SixPlayer;
    GameStage gameStage = GameStageExtension.fromCode(json["status"]);
    Game game = Game(gameType, gameStage);
    return game;
  }

  void notify() => notifyListeners();
}
