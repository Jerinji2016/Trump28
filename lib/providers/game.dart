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
  final String roomId;
  final GameType type;
  GameStage stage;

  Game(this.roomId, this.type, this.stage);

  int get noOfSeats => type == GameType.FourPlayer ? 4 : 6;

  int get noOfPlayers => players.length;

  int? get mySeat {
    int myIndex = players.indexWhere((element) => element.id == Njan().id);
    if (myIndex >= 0) return players[myIndex].serverSeatPosition;
    return null;
  }

  GameHand myHand = GameHand();

  final List<Player> players = [];

  Player? get me {
    Njan njan = Njan();
    Player? me;
    try {
      me = players.firstWhere((element) => element.id == njan.id);
    } catch (e) {}
    return me;
  }

  bool get haveIJoined => mySeat != null;

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
      print(playersJson);

      Njan njan = Njan();
      int mySeat = int.parse(playersJson.keys.firstWhere(
        (k) => playersJson[k]["id"] == njan.id,
        orElse: () => "-1",
      ));
      print("mySeat: $mySeat");

      playersJson.keys.forEach((_seat) {
        int seat = int.parse(_seat);
        int _seatPosition;
        if (mySeat > 0) {
          _seatPosition = seat - mySeat + 1;
          if (_seatPosition < 1) _seatPosition = 6 + _seatPosition;
        } else
          _seatPosition = -1;

        print("server: $seat - client:$_seatPosition");
        print(playersJson[_seat]);
        Map player = playersJson[_seat]..update("serverSeat", (value) => seat, ifAbsent: () => seat);
        game.players.add(Player.fromJson(player, _seatPosition));
      });
    }
    return game;
  }

  void addPlayer(Player player) => (players.length < noOfSeats) ? players.add(player) : print("player full");

  void removePlayer(String id) => players.removeWhere((element) => element.id == id);

  void notify() => notifyListeners();
}
