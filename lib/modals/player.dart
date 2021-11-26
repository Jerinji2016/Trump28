import 'package:flutter/material.dart';

class Player {
  static const int one = 1, two = 2, three = 3, four = 4, five = 5, six = 6;
  static final List<int> fourPlayers = [one, two, three, four];
  static final List<int> sixPlayers = [one, two, three, four, five, six];

  final String name;
  final String id;
  final int serverSeatPosition;
  final int clientSeatPosition;
  bool isReady;

  Player._(this.id, this.name, this.serverSeatPosition, this.isReady, this.clientSeatPosition);

  factory Player.fromJson(Map json, int clientSeatPosition) {
    return Player._(json["id"], json["name"], json["serverSeat"], json["ready"], clientSeatPosition);
  }

  Map<String, dynamic> get map => {"id": id, "name": name, "serverSeat": serverSeatPosition};

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
                  border: Border.all(
                    color: isReady ? Colors.white24 : Colors.red.withOpacity(0.7),
                    width: isReady ? 2 : 3,
                  ),
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
                        name.length > 7 ? name.substring(0, 8) + "..." : name,
                        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 12),
                      ),
                    ),
                    Container(
                      child: Text(
                        "#${id.substring(0, 8)}...",
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
