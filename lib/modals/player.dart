import 'package:flutter/material.dart';

class Player {
  static const int one = 1, two = 2, three = 3, four = 4, five = 5, six = 6;
  static final List<int> fourPlayers = [one, two, three, four];
  static final List<int> sixPlayers = [one, two, three, four, five, six];

  final String name;
  final String id;
  final int serverSeatPosition;
  late final int seatPosition;

  Player._(this.id, this.name, this.serverSeatPosition, this.seatPosition);

  factory Player.fromJson(Map json, int mySeat) {
    int _seatPosition = (json["serverSeat"] + 5 - mySeat) % 6;
    return Player._(json["id"], json["name"], json["serverSeat"], _seatPosition);
  }

  Widget get widget {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                padding: EdgeInsets.symmetric(vertical: 3.0),
                height: 30.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24, width: 2),
                  color: Colors.grey[800]!.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Row(
            children: [
              CircleAvatar(
                child: Text(name[0].toUpperCase()),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 12),
                      ),
                    ),
                    Container(
                      child: Text(
                        "#$id",
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}