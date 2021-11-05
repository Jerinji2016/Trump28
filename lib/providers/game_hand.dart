import 'package:flutter/material.dart';
import 'package:trump28/modals/play_card.dart';

class GameHand extends ChangeNotifier {
  List<PlayCard> cards = [];

  PlayCard? selectedCard;

  void notify() => this.notifyListeners();
}
