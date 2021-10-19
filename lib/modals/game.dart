import 'package:flutter/cupertino.dart';
import 'package:trump28/enums/game_stage.dart';

import 'njan.dart';
import 'player.dart';

enum GameType {
  SixPlayer,
  FourPlayer,
}

class Game extends ChangeNotifier {
  final GameType type;
  GameStage stage;

  static Game? instance;

  int get noOfSeats => type == GameType.FourPlayer ? 4 : 6;

  int get noOfPlayers => players.length;

  final List<Player> players = [];

  bool get haveIJoined => players.any((element) => element.id == Njan().id);

  Game(this.type, this.stage) {
    instance = this;
  }

  factory Game.create(Map json) {
    GameType gameType = json["maxPlayers"] == 4 ? GameType.FourPlayer : GameType.SixPlayer;
    GameStage gameStage = GameStageExtension.fromCode(json["status"]);
    Game game = Game(gameType, gameStage);
    return game;
  }

  void addPlayer(Player player) => (players.length < noOfSeats) ? players.add(player) : print("player full");

  void removePlayer(String id) => players.removeWhere((element) => element.id == id);

  void notify() => notifyListeners();
}
