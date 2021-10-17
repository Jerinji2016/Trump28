enum CardSuit {
  Spade,
  Club,
  Dice,
  Heart
}

extension CardSuitExtension on CardSuit {
  static CardSuit parse(String char) {
    switch (char.toUpperCase()) {
      case "S":
        return CardSuit.Spade;
      case "C":
        return CardSuit.Club;
      case "D":
        return CardSuit.Dice;
      default:
        return CardSuit.Heart;
    }
  }
}

class Card {
  final String id;

  late CardSuit suit;

  Card(this.id) {
    String s = id[0];
    String v = id[1];

    suit = CardSuitExtension.parse(s);
  }
}