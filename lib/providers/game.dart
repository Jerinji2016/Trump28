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
  final Map json;

  String get roomId => json["roomID"];

  GameType get type => json["maxPlayers"] == 4 ? GameType.FourPlayer : GameType.SixPlayer;

  GameStage get stage => GameStageExtension.fromCode(json["status"]);

  Game(this.json);

  int get noOfSeats => type == GameType.FourPlayer ? 4 : 6;

  int get noOfPlayers => players.length;

  String? dealerId;

  int? get mySeat {
    int myIndex = players.indexWhere((element) => element.id == Njan().id);
    if (myIndex >= 0) return players[myIndex].serverSeatPosition;
    return null;
  }

  GameHand myHand = GameHand();

  List<Player> get players {
    List<Player> _players = [];
    if (json.containsKey("players")) {
      Map playersJson = json["players"];

      Njan njan = Njan();
      int mySeat = int.parse(playersJson.keys.firstWhere(
            (k) => playersJson[k]["id"] == njan.id,
        orElse: () => "-1",
      ));

      playersJson.keys.forEach((_seat) {
        int seat = int.parse(_seat);
        int _seatPosition;
        if (mySeat > 0) {
          _seatPosition = seat - mySeat + 1;
          if (_seatPosition < 1) _seatPosition = (type == GameType.SixPlayer ? 6 : 4) + _seatPosition;
        } else
          _seatPosition = -1;

        Map player = playersJson[_seat]..update("serverSeat", (value) => seat, ifAbsent: () => seat);
        _players.add(Player(player, _seatPosition));
      });
    }
    return _players;
  }

  Player? get me {
    Njan njan = Njan();
    Player? me;
    try {
      me = players.firstWhere((element) => element.id == njan.id);
    } catch (e) {}
    return me;
  }

  bool get haveIJoined => mySeat != null;
}
