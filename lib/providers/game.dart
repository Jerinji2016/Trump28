import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump28/enums/game_stage.dart';
import 'package:trump28/providers/game_hand.dart';

import '../modals/njan.dart';
import '../modals/player.dart';

enum GameType {
  SixPlayer,
  FourPlayer,
}

class Game extends ChangeNotifier {
  final GameType type;
  GameStage stage;

  final String roomId;

  static Game? instance;

  int get noOfSeats => type == GameType.FourPlayer ? 4 : 6;

  int get noOfPlayers => players.length;

  int? get mySeat {
    int myIndex = players.indexWhere((element) => element.id == Njan().id);
    if(myIndex >= 0)
      return players[myIndex].serverSeatPosition;
    return null;
  }

  GameHand myHand = GameHand();

  final List<Player> players = [];

  bool get haveIJoined => mySeat != null;

  Game(this.roomId, this.type, this.stage) {
    instance = this;
  }

  factory Game.create(Map json) {
    GameType gameType = json["maxPlayers"] == 4 ? GameType.FourPlayer : GameType.SixPlayer;
    GameStage gameStage = GameStageExtension.fromCode(json["status"]);
    Game game = Game(json["roomID"], gameType, gameStage);
    return game;
  }

  factory Game.parse(Map json) {
    GameType gameType = json["maxPlayers"] == 4 ? GameType.FourPlayer : GameType.SixPlayer;
    GameStage gameStage = GameStageExtension.fromCode(json["status"]);

    Game game = new Game(json["roomID"], gameType, gameStage);
    if (json.containsKey("players")) {
      Map playersJson = json["players"];
      playersJson.keys.forEach((seat) {
        Map player = playersJson[seat]..update("serverSeat", (value) => int.parse(seat), ifAbsent: () => int.parse(seat));
        game.players.add(Player.fromJson(player));
      });
    }
    return game;
  }

  void addPlayer(Player player) => (players.length < noOfSeats) ? players.add(player) : print("player full");

  void removePlayer(String id) => players.removeWhere((element) => element.id == id);

  void notify() => notifyListeners();
}
