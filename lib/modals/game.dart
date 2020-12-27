import 'dart:math';

import 'package:trump28/modals/player.dart';

class Game {
  Map<int, Player> players = new Map();

  int noOfPlayers;
  int noOfCards;

  static String generateId() {
    String vars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_1234567890";

    String id = "";
    for (int i = 0; i < 5; i++) {
      int n = new Random().nextInt(vars.length);
      id += vars[n];
    }
    return id;
  }

  createSeatingForPlayers() {
    while (players.length < noOfPlayers) {
      players.putIfAbsent(players.length + 1, () => null);
    }
    print(players);
  }

  int getPlayerSeat(String id) {
    int seat = 0;
    print(players.length);
    players.forEach((key, value) {
      if (value != null && players[key].id == id) seat = key;
    });

    return seat;
  }
}
