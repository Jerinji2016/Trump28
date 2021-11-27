import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/providers/game_hand.dart';
import 'package:trump28/res/font_map/suits_icons.dart' as SuitIcons;

enum CardSuit { Spade, Club, Dice, Heart }

class PlayCard {
  final Map<String, CardSuit> _suitsMap = const {
    "S": CardSuit.Spade,
    "H": CardSuit.Heart,
    "C": CardSuit.Club,
    "D": CardSuit.Dice,
  };
  final List<String> _values = const ["K", "Q", "J", "T", "9", "8", "7", "6", "A"];

  String get cardValue => (value == "T") ? "10" : value;

  Color get cardColor => (suit == CardSuit.Spade || suit == CardSuit.Club) ? Colors.grey[200]! : Colors.red[700]!;

  IconData get cardIcon {
    switch (suit) {
      case CardSuit.Spade:
        return SuitIcons.Suits.spades;
      case CardSuit.Heart:
        return SuitIcons.Suits.hearts;
      case CardSuit.Club:
        return SuitIcons.Suits.clubs;
      default:
        return SuitIcons.Suits.dice;
    }
  }

  final String id;

  late CardSuit suit;
  late String value;

  PlayCard(this.id) {
    String s = id[0];
    String v = id[1];
    assert(_suitsMap.keys.contains(s));
    assert(_values.contains(v));
    suit = _suitsMap[s]!;
    value = v;
  }

  Widget getWidget(
    BuildContext context,
    int cardIndex,
    Function(PlayCard) onCardTapped,
  ) =>
      PlayCardWidget(cardIndex, this, onCardTapped: onCardTapped);
}

class PlayCardWidget extends StatelessWidget {
  final int cardIndex;
  final PlayCard card;
  final Function(PlayCard)? onCardTapped;

  PlayCardWidget(this.cardIndex, this.card, {Key? key, this.onCardTapped}) : super(key: key);

  final double offset = 35.0;
  late final GameHand gameHand;

  bool get isCardSelected => gameHand.selectedCard?.id == card.id;

  @override
  Widget build(BuildContext context) {
    gameHand = Provider.of<GameHand>(context, listen: false);

    return Positioned(
      left: cardIndex * offset,
      child: GestureDetector(
        onTap: () {
          gameHand.selectedCard = (gameHand.selectedCard == null || gameHand.selectedCard!.id != card.id) ? card : null;
          print("card tapped:${card.id} - inGameHand: ${gameHand.selectedCard?.id}");
          onCardTapped?.call(card);
          gameHand.notify();
        },
        child: Transform.translate(
          offset: Offset(0.0, isCardSelected ? -20.0: 0.0),
          child: Material(
            elevation: 5,
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            child: Container(
              width: 70,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[700]!),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Icon(
                          card.cardIcon,
                          size: 12,
                          color: card.cardColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                        child: Text(
                          card.cardValue,
                          style: TextStyle(
                            color: card.cardColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            card.cardIcon,
                            size: 24,
                            color: card.cardColor,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                            child: Text(
                              card.cardValue,
                              style: TextStyle(color: card.cardColor, fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
