import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/providers/game.dart';

import 'player.dart';

class Message {
  static final List<Color> nameColors = Colors.accents.sublist(0, 6);

  final BuildContext context;
  final String text;
  final String playerId;
  final DateTime time;

  Player get player {
    Game game = Provider.of<Game>(context);
    return game.players.firstWhere((element) => element.id == playerId);
  }

  Color get playerNameColor => nameColors.elementAt(player.serverSeatPosition);

  const Message._(this.context, this.text, this.playerId, this.time);

  factory Message(BuildContext context, Map json) => Message._(
        context,
        json["text"],
        json["playerId"],
        json["time"].toDate(),
      );
}
