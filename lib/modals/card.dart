import 'package:flutter/material.dart';
import 'package:trump28/res/font_map/suits_icons.dart' as SuitIcons;

enum CardSuit { Spade, Club, Dice, Heart }

class PlayCard {
  final Map<String, CardSuit> _suitsMap = const {
    "S": CardSuit.Spade,
    "H": CardSuit.Heart,
    "C": CardSuit.Club,
    "D": CardSuit.Dice,
  };
  final List<String> _values = const ["K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2", "A"];

  String get cardValue => (value == "T") ? "10" : value;

  Color get cardColor => (suit == CardSuit.Spade || suit == CardSuit.Club) ? Colors.grey[100]! : Colors.red[700]!;

  IconData get cardIcon {
    switch (id) {
      case "S":
        return SuitIcons.Suits.spades;
      case "H":
        return SuitIcons.Suits.hearts;
      case "C":
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

  Widget getWidget(BuildContext context, double offset) => Positioned(
    left: offset,
    child: Material(
          elevation: 5,
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Container(
            width: 85,
            height: 110,
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      cardIcon,
                      size: 14,
                      color: cardColor,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      child: Text(
                        cardValue,
                        style: TextStyle(color: cardColor),
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
                          cardIcon,
                          size: 24,
                          color: cardColor,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                          child: Text(
                            cardValue,
                            style: TextStyle(color: cardColor, fontSize: 24),
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
  );
}
