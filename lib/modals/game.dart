import 'package:flutter/cupertino.dart';

import 'player.dart';

enum GameType {
  SixPlayer,
  FourPlayer,
}

enum GameStage {
  /// Players to join
  WaitingLobby,

  /// Game in progress
  InGame,

  /// When Game complete / result
  GameOver,

  /// Player has disconnected
  ErrorPlayerMissing,
}

class Game extends ChangeNotifier {
  final GameType type;
  GameStage stage;

  List<Player> players = [];

  Game(this.type, this.stage);

  factory Game.create(GameType type) {
    Game game = Game(type, GameStage.WaitingLobby);

    List<Map> playersJson = [
      {
        "name": "Zoheb",
        "id": "ANSWER",
        "serverSeat": 1,
      },
      {
        "name": "Jenson",
        "id": "LAPTOP",
        "serverSeat": 2,
      },
      {
        "name": "Raman",
        "id": "MOBILE",
        "serverSeat": 3,
      },
      {
        "name": "Jerin",
        "id": "WINDOW",
        "serverSeat": 4,
      },
      {
        "name": "Shafas",
        "id": "BASKET",
        "serverSeat": 5,
      },
      {
        "name": "Muzzle",
        "id": "BAKERY",
        "serverSeat": 6,
      },
    ];

    int mySeat = 4;

    playersJson.forEach((e) => game.players.add(Player.fromJson(e, mySeat)));
    return game;
  }

  void notify() => notifyListeners();
}
