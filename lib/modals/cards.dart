import 'package:flutter/material.dart';
import 'package:trump28/helper/game.dart';
import 'package:trump28/res/clubs.dart';
import 'package:trump28/res/diamonds.dart';
import 'package:trump28/res/hearts.dart';
import 'package:trump28/res/spades.dart';

class Cards {
  final String name;
  final Color color;
  final int value;
  final int suitNo;
  final String id;

  Widget suit;

  Cards({this.id, this.name, this.value, this.suitNo, this.color}) : super() {
    switch (this.suitNo) {
      case 1:
        suit = Spades();
        break;
      case 2:
        suit = Hearts();
        break;
      case 3:
        suit = Clubs();
        break;
      case 4:
        suit = Diamonds();
        break;
    }
    print("suited! :)");
  }
  Offset pop = Offset(0, -25);

  Widget card() => Container(
        margin: EdgeInsets.all(5.0),
        child: ValueListenableBuilder(
            valueListenable: Game.selectedCard,
            builder: (context, val, child) {
              return Transform.translate(
                offset: this.id == val ? pop : Offset(0, 0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 15.0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      Game.selectedCard.value = (this.id == val) ? "" : this.id;
                    },
                    splashColor: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      width: 100.0,
                      height: 160.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey[500], width: 0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              this.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: this.color,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            child: Container(
                              child: this.suit,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Transform.scale(
                                    scale: 3.5,
                                    child: this.suit,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
}
