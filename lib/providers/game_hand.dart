import 'package:flutter/cupertino.dart';
import 'package:trump28/modals/play_card.dart';

class GameHand {
  List<PlayCard> cards = [];

  ValueNotifier<PlayCard?> selectedCard = new ValueNotifier(null);
}
